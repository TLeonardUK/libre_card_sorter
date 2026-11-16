# Libre Card Sorter
# Copyright (C) 2026 Tim Leonard, All Rights Reserved

from PyQt6.QtWidgets import QApplication, QWidget
from PyQt6.QtGui import QIcon
import sys
from Windows.MainWindow import MainWindow
from Sorting.CardSorting import CardSorter, CardSorterState
from Sorting.CardIdentification import CardIdentifier, CardIdentity, CardInfo
from Workflow.Workflows import Workflow, WorkflowBin, WorkflowCardArchetype, WorkflowCardArchetypeRule, WorkflowCardArchetypeRuleOperator, WorkflowMatchBehaviour, WorkflowExecutionState
from Settings import Settings
from Workflow.WorkflowExecution import WorkflowExecutor
import time
import asyncio
import uuid
from PIL import Image

async def main():
    app = QApplication(sys.argv)
    app.setWindowIcon(QIcon(Settings.APP_ICON_PATH))
    window = MainWindow()
    window.show()
    app.exec()

if __name__ == "__main__":
    asyncio.run(main())


