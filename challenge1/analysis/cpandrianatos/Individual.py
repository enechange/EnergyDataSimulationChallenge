from Node import *

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class Individual:
    root: Node
    fitness: float

    standardisedFitness: float
    adjustedFitness: float
    normalizedFitness: float

    """
        Each individual is one tree generated by the Genetic Program (GP).
        The fitness and associated standardisedFitness, adjustedFitness, and normalizedFitness are stored in
        each individual.
        The standardisedFitness, adjustedFitness, normalizedFitness are used during Fitness proportionate selection to
        select new individuals for the next generation.
        The fitness for an individual is the MAPE over every data entry (row in dataset) and multiplied by 100.
    """

    def __init__(self, newRoot: Node, newFitness: float):
        self.root = newRoot
        self.fitness = newFitness
        self.standardisedFitness = 0
        self.adjustedFitness = 0
        self.normalizedFitness = 0

    def getRoot(self):
        return self.root

    def getFitness(self):
        return self.fitness

    def setFitness(self, newFitness):
        self.fitness = newFitness

    def getStandardisedFitness(self):
        return self.standardisedFitness

    def setStandardisedFitness(self, newStandardisedFitness):
        self.standardisedFitness = newStandardisedFitness

    def getAdjustedFitness(self):
        return self.adjustedFitness

    def setAdjustedFitness(self, newAdjustedFitness):
        self.adjustedFitness = newAdjustedFitness

    def getNormalisedFitness(self):
        return self.normalizedFitness

    def setNormalisedFitness(self, newNormalisedFitness):
        self.normalizedFitness = newNormalisedFitness

    def resetValues(self):
        self.fitness = 0.0
        self.standardisedFitness = 0
        self.adjustedFitness = 0
        self.normalizedFitness = 0

    # Recursive function will print the tree associated with this individual
    def printTree(self, node, appender):
        if node is None:
            return
        print(appender, node.getLabel())
        if node.getLabel() is None:
            return
        if node.getChildren() is None:
            return
        for n in node.getChildren():
            if n is not None:
                self.printTree(n, appender + "-")