# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

from enum import Enum
from Sorting.CardIdentification import CardIdentity, CardInfo
from Sorting.CardSchema import CARD_FIELDS, CardBoolean, CardFieldName, CardFieldType, find_card_field

from dataclasses import dataclass
from typing import Annotated, get_type_hints, get_args, get_origin

@dataclass(frozen=True)
class Comment:
    text: str

# Different types of operators that can be used in a condition.
class WorkflowCardArchetypeRuleOperator(str, Enum):
    EQUAL = "Equal"
    NOT_EQUAL = "NotEqual"
    LESS = "Less"
    GREATER = "Greater"
    LESS_EQUAL = "LessEqual"
    GREATER_EQUAL = "GreaterEqual"
    CONTAINS = "Contains"
    NOT_CONTAINS = "NotContains"

# Condition for determining if a card should be placed in a given bin.
# This allows you to do things like: ManaType == "red"
class WorkflowCardArchetypeRule:

    FIELD_DESCRIPTION = {
        "attribute_name":    "Attribute to get from the card.",
        "operator":         "How to compare the attribute with the value.",
        "value":            "Value to compare against."
    }
    
    def __init__(self, attribute, operator, value):     
        self.operator = operator
        self.value =  value
        self.attribute_name = attribute

    # Changing the attribute also changes the operator and value if they no longer suit it.
    @property
    def attribute_name(self):
        return self.__attribute_name

    @attribute_name.setter
    def attribute_name(self, attribute_name):
        self.__attribute_name = CardFieldName(attribute_name)

        operators = self.get_field_choices("operator")
        if (self.operator not in operators):
            self.operator = operators[0]

        field = find_card_field(self.__attribute_name)
        if (field.values != None):
            try:
                self.value = field.values(self.value)
            except ValueError:
                self.value = self.get_field_choices("value")[0]
        else:
            self.value = str(self.value)
            if (self.is_number_field("value")):
                try:
                    float(self.value)
                except ValueError:
                    self.value = "0"

    # Values a field can be set to, or None if it can be set to anything.
    def get_field_choices(self, key):
        field = find_card_field(self.attribute_name)
        if (key == "attribute_name"):
            names = []
            for card_field in CARD_FIELDS:
                names.append(card_field.name)
            return names
        elif (key == "operator"):
            if (field.type == CardFieldType.NUMBER):
                return [
                    WorkflowCardArchetypeRuleOperator.EQUAL,
                    WorkflowCardArchetypeRuleOperator.NOT_EQUAL,
                    WorkflowCardArchetypeRuleOperator.LESS,
                    WorkflowCardArchetypeRuleOperator.GREATER,
                    WorkflowCardArchetypeRuleOperator.LESS_EQUAL,
                    WorkflowCardArchetypeRuleOperator.GREATER_EQUAL
                ]
            elif (field.type == CardFieldType.LIST):
                return [
                    WorkflowCardArchetypeRuleOperator.CONTAINS,
                    WorkflowCardArchetypeRuleOperator.NOT_CONTAINS
                ]
            elif (field.values != None):
                return [
                    WorkflowCardArchetypeRuleOperator.EQUAL,
                    WorkflowCardArchetypeRuleOperator.NOT_EQUAL
                ]
            else:
                return [
                    WorkflowCardArchetypeRuleOperator.EQUAL,
                    WorkflowCardArchetypeRuleOperator.NOT_EQUAL,
                    WorkflowCardArchetypeRuleOperator.CONTAINS,
                    WorkflowCardArchetypeRuleOperator.NOT_CONTAINS
                ]
        elif (key == "value"):
            if (field.values == None):
                return None
            values = []
            for member in field.values:
                values.append(member)
            return values
        return None

    def is_number_field(self, key):
        return (key == "value" and find_card_field(self.attribute_name).type == CardFieldType.NUMBER)

# Set of conditions and quantity of cards wanted by a given list.
# All conditions need to evaluate to true for the card to be valid
# to place in a bin.
class WorkflowCardArchetype:
   
    FIELD_DESCRIPTION = {
        "name":             "Name of this archetype.",
        "quantity":         "Maximum quantity of this archetype to add to bin. Can be used to do things like only have 2 of a specific card in a bin. Zero means unlimited."
    }
    
    def __init__(self, name, quantity, rules):
        self.name = name
        self.quantity = quantity
        self.rules = rules

# Individual bin that a workflow can put cards in.
class WorkflowBin:

    FIELD_DESCRIPTION = {
        "name":             "Name of this bin.",
        "capacity":         "Maximum number of cards this bin can recieve. Sorting will be paused for emptying if it get full."
    }
    
    def __init__(self, name, capacity, archetypes):
        self.name = name
        self.capacity = capacity
        self.archetypes = archetypes


# How the workflow handles multiple bins wanting the same card.
class WorkflowMatchBehaviour(str, Enum):
    LEAST_CARDS = "LeastCards"       # Card sorter will put it in the bin with the least number of cards in it.
    LEFT_TO_RIGHT = "LeftToRight"     # First bin from the left
    RIGHT_TO_LEFT = "RightToLeft"     # First bin from the right

# Workflow that can be run by the card sorter. Defines a set of bins
# and the lists of cards they each want to take.
#
# When matching which bin a card should go in goes with greedy matching, the bin the matches
# the most criteria matched gets the card.
class Workflow:

    FIELD_DESCRIPTION = {
        "name":             "Name of this workflow.",
        "match_behaviour":   "How to handle situations where multiple bins are valid choices for a card."
    }
    
    def __init__(self, name, match_behaviour, bins):
        self.name = name
        self.bins = bins
        self.match_behaviour = match_behaviour

    # Returns true if any rule needs to know whether a card is foil, which costs extra captures per card.
    # PRICE_USD counts as it picks the foil or nonfoil price.
    def depends_on_foil(self):
        for workflow_bin in self.bins:
            for archetype in workflow_bin.archetypes:
                for rule in archetype.rules:
                    if (rule.attribute_name == CardFieldName.IS_FOIL or rule.attribute_name == CardFieldName.PRICE_USD):
                        return True
        return False


# Stores runtime info about the execution of a workflow, things that change
# over time such as bin counts. A new instance of this should be created
# each time a workflow is run.
class WorkflowExecutionState:

    class WorkflowBinState:
        def __init__(self, bin):
            # How many cards in this bin.
            self.card_count = 0
            # Count of cards that have been placed in this bin that matched the archetype index
            self.archetype_card_counts = [0] * len(bin.archetypes)

    def __init__(self, workflow):
        self.__workflow = workflow
        self.__bin_states = []
        for bin in workflow.bins:
            self.__bin_states.append(self.WorkflowBinState(bin))

    # Finds a bin index we can put unknown cards in. Typically
    # one with no rules or defaulting to 0.
    def __find_unknown_card_bin_index(self):
        for bin_index in range(len(self.__workflow.bins)):
            workflow_bin = self.__workflow.bins[bin_index]
            if (len(workflow_bin.archetypes) == 0):
                return bin_index
        return 0

    def __select_unknown_card_bin(self):
        bin_index = self.__find_unknown_card_bin_index()
        self.__bin_states[bin_index].card_count += 1
        return bin_index

    # Gets the given card attribute by name
    def __get_card_attribute(self, card_identity, attribute_name):
        # Couple of special attributes that are retrieved from different places.
        if (attribute_name == CardFieldName.PRICE_USD):
            return card_identity.info.attributes[CardFieldName.PRICE_USD_FOIL] if card_identity.is_foil else card_identity.info.attributes[CardFieldName.PRICE_USD_NONFOIL]
        elif (attribute_name == CardFieldName.IS_FOIL):
            return CardBoolean.TRUE if card_identity.is_foil else CardBoolean.FALSE
        # Get from the standard attributes array
        else:
            if (attribute_name not in card_identity.info.attributes):
                return None
            return card_identity.info.attributes[attribute_name]

    # Checks if rule matches the card identity and returns true if it does.
    def __match_rule(self, card_identity, rule):
        attribute = self.__get_card_attribute(card_identity, rule.attribute_name)
        if (attribute == None):
            return False

        if (rule.operator == WorkflowCardArchetypeRuleOperator.EQUAL):
            if (isinstance(attribute, str)):
                return (attribute.lower() == rule.value.lower())
            elif (isinstance(attribute, float)):
                return (attribute == float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute == int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.NOT_EQUAL):
            if (isinstance(attribute, str)):
                return (attribute.lower() != rule.value.lower())
            elif (isinstance(attribute, float)):
                return (attribute != float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute != int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.LESS):
            if (isinstance(attribute, float)):
                return (attribute < float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute < int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.GREATER):
            if (isinstance(attribute, float)):
                return (attribute > float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute > int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.LESS_EQUAL):
            if (isinstance(attribute, float)):
                return (attribute <= float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute <= int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.GREATER_EQUAL):
            if (isinstance(attribute, float)):
                return (attribute >= float(rule.value))
            elif (isinstance(attribute, int)):
                return (attribute >= int(rule.value))
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.CONTAINS):
            if (isinstance(attribute, str)):
                return (attribute.lower().find(rule.value.lower()) >= 0)
            elif (isinstance(attribute, list)):
                for elem in attribute:
                    if (isinstance(elem, str)):
                        if (elem.lower() == rule.value.lower()):
                            return True
                    elif (isinstance(elem, float)):
                        if (elem == float(rule.value)):
                            return True
                    elif (isinstance(elem, int)):
                        if (elem == int(rule.value)):
                            return True
                return False
        elif (rule.operator == WorkflowCardArchetypeRuleOperator.NOT_CONTAINS):
            if (isinstance(attribute, str)):
                return (attribute.lower().find(rule.value.lower()) < 0)
            elif (isinstance(attribute, list)):
                for elem in attribute:
                    if (isinstance(elem, str)):
                        if (elem.lower() == rule.value.lower()):
                            return False
                    elif (isinstance(elem, float)):
                        if (elem == float(rule.value)):
                            return False
                    elif (isinstance(elem, int)):
                        if (elem == int(rule.value)):
                            return False
                return True

        return False
    
    # Returns the number of cards in a bin.
    def get_bin_card_count(self, bin_index):
        return self.__bin_states[bin_index].card_count

    # Returns the capacity of a given bin
    def get_bin_card_capacity(self, bin_index):
        return self.__workflow.bins[bin_index].capacity

    # Marks all bins as containing no cards.
    def mark_bins_as_empty(self):
        for state in self.__bin_states:
            state.card_count = 0
    
    # Returns true if any of the workflow bins are full to capacity.
    def any_bins_full(self):
        for bin_index in range(len(self.__workflow.bins)):
            workflow_bin = self.__workflow.bins[bin_index]
            if (workflow_bin.capacity > 0 and self.__bin_states[bin_index].card_count >= workflow_bin.capacity):
                return True
        return False

    # Select the best matching bin based on the workflow rules.
    def select_bin(self, card_identity):
        # If card was unrecognized
        if (card_identity == None):
            return self.__select_unknown_card_bin()

        # Find bins we can match against.
        matching_bin_index_and_archetype_indexes_and_priority = []
        for bin_index in range(len(self.__workflow.bins)):
            workflow_bin = self.__workflow.bins[bin_index]
            bin_state = self.__bin_states[bin_index]

            matching_archetype_indexes = []
            matching_rule_count = 0
            for archetype_index in range(len(workflow_bin.archetypes)):
                archetype = workflow_bin.archetypes[archetype_index]
                if (archetype.quantity != 0 and bin_state.archetype_card_counts[archetype_index] >= archetype.quantity):
                    continue

                all_rules_match = True
                for rule in archetype.rules:
                    if (not self.__match_rule(card_identity, rule)):
                        all_rules_match = False
                        break

                if (all_rules_match):
                    matching_rule_count += len(archetype.rules)
                    matching_archetype_indexes.append(archetype_index)

            if (len(matching_archetype_indexes) > 0):
                matching_bin_index_and_archetype_indexes_and_priority.append((bin_index, matching_archetype_indexes, matching_rule_count))

        # No matching bins? Find one that is empty.
        if (len(matching_bin_index_and_archetype_indexes_and_priority) == 0):
            return self.__select_unknown_card_bin()

        # Get the match with the highest priority.
        sorted_bins = sorted(matching_bin_index_and_archetype_indexes_and_priority, key=lambda tup: tup[2])
        top_priority = sorted_bins[0][2]
        same_priority_bins = [item for item in sorted_bins if item[2] == top_priority]

        best_match = 0

        # If only one bin left, just return its index.
        if (len(same_priority_bins) == 1):
            best_match = same_priority_bins[0]
        else:
            # Otherwise use the match criteria
            if (self.__workflow.match_behaviour == WorkflowMatchBehaviour.LEAST_CARDS):
                best_card_count = -1
                best_bin_index = 0
                for bin_info in same_priority_bins:
                    bin_index = bin_info[0]
                    bin_card_count = self.__bin_states[bin_index].card_count
                    if (best_card_count == -1 or bin_card_count < best_card_count):
                        best_card_count = bin_card_count
                        best_match = bin_info
            elif (self.__workflow.match_behaviour == WorkflowMatchBehaviour.LEFT_TO_RIGHT):
                best_bin_index = -1
                for bin_info in same_priority_bins:
                    bin_index = bin_info[0]
                    if (best_bin_index == -1 or bin_index < best_bin_index):
                        best_bin_index = bin_index
                        best_match = bin_info
            elif (self.__workflow.match_behaviour == WorkflowMatchBehaviour.RIGHT_TO_LEFT):
                best_bin_index = -1
                for bin_info in same_priority_bins:
                    bin_index = bin_info[0]
                    if (best_bin_index == -1 or bin_index > best_bin_index):
                        best_bin_index = bin_index
                        best_match = bin_info
            else:
                raise Exception("Unknown match behaviour. Have you added a new behaviour without implementing it?") 

        # Increase card counts
        bin_state = self.__bin_states[best_match[0]]
        bin_state.card_count += 1
        for archetype_index in best_match[1]:
            bin_state.archetype_card_counts[archetype_index] += 1

        # Return bin index
        return best_match[0]
        