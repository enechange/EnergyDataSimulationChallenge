from Node import Node

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class TerminalNode(Node):
    label: str

    # variables in data
    # ID Label House Year Month Temperature Daylight EnergyProduction

    """
        Each terminal nodes represents one variable in each data entry (row in dataset), excluding the ID and
        EnergyProduction, you can't use EnergyProduction during training since that is what you are trying to
        predict.
        Terminal nodes are considered leaf nodes and do not have children.
    """

    def __init__(self, label: str):
        super().__init__()
        self.label = label

    def getLabel(self) -> str:
        return self.label

    def setLabel(self, newLabel: str):
        self.label = newLabel

    # Return 1 since these are leaf nodes in the tree
    def CountNodes(self) -> int:
        return 1
