"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class Node(object):

    """
        Base class for functional and terminal nodes
    """

    def __init__(self):
        pass

    def getLabel(self) -> str:
        pass

    def setLabel(self, newLabel: str):
        pass

    def getChildren(self) -> list:
        pass

    def setChildren(self, newChildren: list):
        pass

    def CountNodes(self) -> int:
        pass
