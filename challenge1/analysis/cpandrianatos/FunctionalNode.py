from Node import Node

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class FunctionalNode(Node):
    label: str

    children: list

    """
        Possible operators + - * /
        Each functional node will either have the mathematical operation plus, minus, multiply, or divide.
        Functional nodes can either be the root or are situated above the terminal nodes.
        Functional nodes have children (a max of 2).
    """

    def __init__(self, label: str, children: list):
        super().__init__()
        self.label = label
        self.children = children

    def getLabel(self) -> str:
        return self.label

    def setLabel(self, newLabel: str):
        self.label = newLabel

    def getChildren(self) -> list:
        return self.children

    def setChildren(self, newChildren: list):
        self.children = newChildren

    # Count nodes from this node downwards, this a recursive function and is
    # usually run from the root node downwards
    def CountNodes(self) -> int:
        c = 1
        if not self.children:
            return c
        for i in range(0, len(self.children)):
            if self.children[i] is not None:
                c += self.children[i].CountNodes()
        return c
