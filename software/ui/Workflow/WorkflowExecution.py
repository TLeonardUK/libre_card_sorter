# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

import io
import sys
import time
from enum import Enum
from PIL import Image
from threading import Thread, Lock
from Workflow.Workflows import Workflow, WorkflowExecutionState
from Sorting.CardIdentification import CardIdentifier, CardIdentity, CardInfo
from Sorting.CardSorting import CardSorter, CardSorterState, CardSorterNotIdleException
from Sorting.CardSchema import CardFieldName, CardFinish

# Defines what state the executor is currently running in.
class WorkflowExecutorRunState(Enum):
    STOPPED = 1
    RUNNING = 2
    PAUSED = 3
    BIN_FULL = 4
    COMPLETED = 5
    ERROR = 6

class WorkflowExecutorInvalidStateException(Exception):
    pass

class WorkflowAbortedException(Exception):
    pass

# Entry in the running list of cards processed by the workflow executor.
class CardListEntry:
    def __init__(self):
        self.card_identity = None
        self.bin_index = None
        self.quantity = 0

# Running list of the cards processed, owned by the UI rather than an executor so it can outlive a workflow run.
class CardList:
    def __init__(self):
        self.__entries = []
        self.__lock = Lock()
        self.__revision = 0

    def add(self, card_identity, bin_index, quantity):
        with self.__lock:
            self.__revision += 1
            for entry in self.__entries:
                if (entry.card_identity.info.id == card_identity.info.id and entry.card_identity.is_foil == card_identity.is_foil and entry.bin_index == bin_index):
                    entry.quantity += quantity
                    return

            entry = CardListEntry()
            entry.card_identity = card_identity
            entry.bin_index = bin_index
            entry.quantity = quantity
            self.__entries.append(entry)

    # Changes whenever the list does, so it's only saved when needed.
    def get_revision(self):
        with self.__lock:
            return self.__revision

    def get_entries(self):
        with self.__lock:
            return self.__entries.copy()

    def clear(self):
        with self.__lock:
            self.__revision += 1
            self.__entries = []

# This class is responsible for driving a card sorter from the rules
# setout in a workflow. This is the main class that the UI itself interacts with.
# Execution is performed on a seperate thread to avoid blocking the UI at any point.
class WorkflowExecutor:

    def __init__(self, card_sorter, card_identifier, settings, card_list):        
        self.__card_sorter = card_sorter
        self.__settings = settings
        self.__card_identifier = card_identifier
        self.__workflow_state = None
        self.__run_state = WorkflowExecutorRunState.STOPPED
        self.__is_homed = False
        self.__is_aborted = False
        self.__is_shut_down = False
        self.__was_interrupted = False
        self.__error = ""
        self.__workflow = None
        self.__workflow_depends_on_foil = False
        self.__identifying_card = False
        self.__identifying_card_foil = False
        self.__last_card_identity = CardIdentity()
        self.__card_list = card_list
        self.__card_cycle_durations = []
        self.__process_thread = Thread(target = self.__thread_entry, daemon = True)
        self.__process_thread.start()

    # The UI thread polls the sorter; this only waits for the state it leaves.
    def __wait_until_sorter_idle(self):
        while (True):
            if (self.__is_aborted):
                raise WorkflowAbortedException()
            state = self.__card_sorter.get_state()
            if (state == CardSorterState.IDLE):
                return
            if (not self.__card_sorter.is_connected() or state == CardSorterState.ERROR):
                raise WorkflowAbortedException()
            time.sleep(0.01)

    # Starts a sorter operation once the sorter is free. The UI's periodic state poll can take the sorter between it
    # going idle and the operation being sent, so a refused operation is tried again.
    def __run_sorter_operation(self, operation, *args):
        while (True):
            self.__wait_until_sorter_idle()
            try:
                operation(*args)
                return
            except CardSorterNotIdleException:
                pass

    def __thread_entry(self):
        while (not self.__is_shut_down):
            # Wait if not currently running.
            if (self.__run_state != WorkflowExecutorRunState.RUNNING):
                time.sleep(0.01)
                continue

            # If any bins are full then stop.
            if (self.__workflow_state.any_bins_full()):
                self.__run_state = WorkflowExecutorRunState.BIN_FULL
                continue

            try:
                self.__run_cycle()
            except WorkflowAbortedException:
                # Emergency stopped, shut down, or the sorter disconnected or failed; nothing more can be done until restarted.
                if (not self.__is_aborted):
                    self.__was_interrupted = True
                if (self.__run_state == WorkflowExecutorRunState.RUNNING):
                    self.__run_state = WorkflowExecutorRunState.STOPPED
            except Exception as e:
                print(f"Workflow failed: {e}")
                self.__error = str(e)
                self.__run_state = WorkflowExecutorRunState.ERROR
            self.__identifying_card = False
            self.__identifying_card_foil = False


    def __track_card(self, card_identity, bin_index):
        if (card_identity == None):
            return

        self.__card_list.add(card_identity, bin_index, 1)

    def get_cards_per_minute(self):
        durations = self.__card_cycle_durations
        if (len(durations) == 0):
            return None
        return 60.0 / (sum(durations) / len(durations))

    def get_workflow(self):
        return self.__workflow

    # Returns true if currnetly in the process of identifying the next card.
    def is_identifying_card(self):
        return self.__identifying_card
    
    # Returns true if currnetly in the process of identifying if the card is foil.
    def is_identifying_card_foil(self):
        return self.__identifying_card_foil    
    
    # Returns the identity of the last card identified.
    def get_last_card_identity(self):
        return self.__last_card_identity

    # Returns the number of cards in a bin
    def get_bin_card_count(self, bin_index):
        return self.__workflow_state.get_bin_card_count(bin_index)

    # Returns the capacity of a bin
    def get_bin_card_capacity(self, bin_index):
        return self.__workflow_state.get_bin_card_capacity(bin_index)

    # Sorts one card, raising WorkflowAbortedException at the next wait for the sorter if emergency stopped.
    def __run_cycle(self):
        # If this is the first execution, then home first.
        if (not self.__is_homed):
            self.__run_sorter_operation(self.__card_sorter.home)
            self.__wait_until_sorter_idle()
            self.__is_homed = True
        
        cycle_start_time = time.monotonic()

        # Load the next card to the top of the stack.
        self.__run_sorter_operation(self.__card_sorter.load_card)
        self.__wait_until_sorter_idle()

        # The probe found no card before the stack ran out of travel.
        if (self.__card_sorter.is_magazine_empty()):
            self.__run_state = WorkflowExecutorRunState.COMPLETED
            return

        self.__identifying_card = True

        # Get an webcam capture of the current card.
        self.__run_sorter_operation(self.__card_sorter.request_new_card_image)
        self.__wait_until_sorter_idle()

        card_image = self.__card_sorter.get_card_image()
        card_identity = self.__card_identifier.identify_card(card_image)

        if (card_identity != None):
            
            # If its ever been printed in foil get multiple images to determine if its foil.
            finishes = card_identity.info.attributes[CardFieldName.FINISHES]
            if (CardFinish.FOIL in finishes):
                self.__identifying_card_foil = True
                if (len(finishes) == 1):
                    card_identity.is_foil = True
                elif (self.__workflow_depends_on_foil or not self.__settings.skip_unneeded_foil_check):
                    # Grab images with various LED's on/off to dermine if this is a foil
                    light_cards = []
                    led_light_card_count = 3
                    led_steps = 12 / led_light_card_count
                    for i in range(led_light_card_count):
                        self.__run_sorter_operation(self.__card_sorter.request_new_card_image_led_controlled, i * led_steps)
                        self.__wait_until_sorter_idle()

                        foil_image = self.__card_sorter.get_card_image()
                        if (card_identity.flipped):
                            foil_image = foil_image.transpose(method=Image.ROTATE_180)

                        light_cards.append(foil_image)

                    card_identity.is_foil = self.__card_identifier.identify_foil(light_cards)       
                self.__identifying_card_foil = False

            print(f"Card={card_identity.info.name} Foil={card_identity.is_foil}")

        # Match the workflow rules to select the correct bin for this card.
        target_bin_index = self.__workflow_state.select_bin(card_identity)

        self.__identifying_card = False
        self.__last_card_identity = card_identity
        
        self.__track_card(card_identity, target_bin_index)
        
        # Deliver the card to the selected bin.
        self.__run_sorter_operation(self.__card_sorter.deliver_card_to_bin, target_bin_index)
        self.__wait_until_sorter_idle()            

        # Only recent cards are averaged so the rate follows changes in speed (e.g. foil checks).
        self.__card_cycle_durations = self.__card_cycle_durations[-9:] + [time.monotonic() - cycle_start_time]

    # Marks all bins as containing no cards.
    def mark_bins_as_empty(self):
        return self.__workflow_state.mark_bins_as_empty()

    # Starts running the workflow from the beginning
    def start(self, workflow):
        if (self.__run_state != WorkflowExecutorRunState.STOPPED and self.__run_state != WorkflowExecutorRunState.COMPLETED and self.__run_state != WorkflowExecutorRunState.BIN_FULL and self.__run_state != WorkflowExecutorRunState.ERROR):
            raise WorkflowExecutorInvalidStateException()
        self.__is_homed = False
        self.__is_aborted = False
        self.__workflow = workflow
        self.__workflow_state = WorkflowExecutionState(self.__workflow)
        self.__workflow_depends_on_foil = workflow.depends_on_foil()
        self.__card_cycle_durations = []
        self.__run_state = WorkflowExecutorRunState.RUNNING

    # Stops running the workflow 
    def stop(self):
        if (self.__run_state != WorkflowExecutorRunState.RUNNING):
            raise WorkflowExecutorInvalidStateException()
        self.__run_state = WorkflowExecutorRunState.STOPPED

    # Stops running the workflow straight away, abandoning the card being sorted; the sorter must be stopped as well.
    def emergency_stop(self):
        self.__is_aborted = True
        self.__run_state = WorkflowExecutorRunState.STOPPED

    # Ends the executor's thread, abandoning anything in progress. Call when discarding the executor.
    def shutdown(self):
        self.__is_shut_down = True
        self.emergency_stop()

    # Whether the workflow was cut short by the sorter disconnecting or failing.
    def was_interrupted(self):
        return self.__was_interrupted

    # Why the workflow stopped in the ERROR state.
    def get_error(self):
        return self.__error

    # Acknowledges an error, leaving the workflow stopped.
    def clear_error(self):
        if (self.__run_state == WorkflowExecutorRunState.ERROR):
            self.__run_state = WorkflowExecutorRunState.STOPPED

    # Pauses execution
    def pause(self):
        if (self.__run_state != WorkflowExecutorRunState.RUNNING):
            raise WorkflowExecutorInvalidStateException()
        self.__run_state = WorkflowExecutorRunState.PAUSED

    # Resumes previously paused executions, or carries on once full bins have been emptied.
    def resume(self):
        if (self.__run_state != WorkflowExecutorRunState.PAUSED and self.__run_state != WorkflowExecutorRunState.BIN_FULL):
            raise WorkflowExecutorInvalidStateException()
        self.__run_state = WorkflowExecutorRunState.RUNNING

    # Returns the current running state of the executor.
    def get_run_state(self):
        return self.__run_state 

