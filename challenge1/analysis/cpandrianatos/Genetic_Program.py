import random
import sys

from TerminalNode import TerminalNode
from Node import Node
from FunctionalNode import FunctionalNode
from Individual import Individual
from DataReader import DataReader

import copy
import re

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class Genetic_Program:
    seed: int
    max_generations: int
    pop_size: int
    max_depth: int
    crossover_chance: float
    mutation_chance: float
    reproduction_chance: float

    ramped_half_half: float

    population: list
    newPopulation: list

    matingPool: list

    bestIndividual: Individual

    totalAdjusted: float

    def __init__(self):
        self.seed = 0
        self.max_generations = 1
        self.pop_size = 1
        self.max_depth = 3
        self.crossover_chance = 0.6
        self.mutation_chance = 0.3
        self.reproduction_chance = 0.1
        self.ramped_half_half = 0.5

        self.population = []

        self.newPopulation = []

        # Matingpool of individuals used during Fitness Proportionate Selection
        self.matingPool = []

        # Used Fitness Proportionate Selection
        self.totalAdjusted = 0.0

        # 100000.0 is the starting fitness, the best individual is the one with the lowest fitness in a population
        # 100000.0 was picked arbitrarily, it can be any large number, that should not be encountered when training
        self.bestIndividual = Individual(Node(), 100000.0)

    def Perform_Run(self, filename, seed, maxGen, popSize, maxDepth, cross, mutate, reproduction,
                    ramped_half_half, random_seed):
        self.seed = seed
        # If set to 1 in parameters.config, a random seed will be used instead of the user-provided one
        if random_seed:
            self.seed = random.randrange(sys.maxsize)
        random.seed(self.seed)
        self.max_generations = maxGen
        self.pop_size = popSize
        self.max_depth = maxDepth
        self.crossover_chance = cross
        self.mutation_chance = mutate
        self.reproduction_chance = reproduction
        self.ramped_half_half = ramped_half_half

        # Data is read in from the training dataset
        dr = DataReader(filename)

        data = dr.ReadInData()

        # Data is shuffled to try and make each training unique and hopefully means we avoid local minimums.
        random.shuffle(data)

        # Generating the initial population of trees
        self.InitialPopulationGeneration()

        currentGeneration = 0

        while currentGeneration < self.max_generations:
            print("Generation: ", currentGeneration)

            for i in range(0, len(self.population)):
                fitness = 0.0
                # Each individuals are run with each data entry to calculate MAPE and use it for the fitness for each individual
                for j in range(0, len(data)):
                    prediction = self.RunGP(self.population[i], self.population[i].getRoot(), data[j])

                    fitness += abs((float(data[i].getEnergyProduction()) - prediction) / float(data[i].getEnergyProduction()))

                fitness = fitness * (1 / len(data))
                # The fitness (actually MAPE) is multiplied by 100
                fitness = fitness * 100
                self.population[i].setFitness(fitness)

                # Update best individual
                if self.bestIndividual.getFitness() > fitness:
                    self.bestIndividual = copy.deepcopy(self.population[i])

                # The fitnesses used in Fitness Proportionate Selection is calculated
                self.population[i].setStandardisedFitness(self.population[i].getFitness())

                tempAdjustedFitness = 1 / (1 + self.population[i].getStandardisedFitness())

                self.population[i].setAdjustedFitness(tempAdjustedFitness)

                self.totalAdjusted += self.population[i].getAdjustedFitness()

            self.CreateFitnessProportionateSelection()

            # These genetic operators are used to populate the new population used in the next generation
            while len(self.newPopulation) < self.pop_size:
                rand = random.random()
                if rand <= self.crossover_chance and (len(self.newPopulation) <= self.pop_size - 2):
                    self.CrossOver()
                elif rand <= self.mutation_chance:
                    self.Mutation()
                elif rand <= self.reproduction_chance:
                    self.Reproduction()

            self.population = []

            for i in range(0, len(self.newPopulation)):
                self.population.append(copy.deepcopy(self.newPopulation[i]))

            self.newPopulation = []

            self.totalAdjusted = 0.0

            self.matingPool = []

            currentGeneration += 1

            print("Best Individual Fitness: ", self.bestIndividual.getFitness())
            self.bestIndividual.printTree(self.bestIndividual.getRoot(), "-")

        print("Best Final Individual Fitness: ", self.bestIndividual.getFitness())
        self.bestIndividual.printTree(self.bestIndividual.getRoot(), "-")
        print("Seed: ", self.seed)

        return [self.bestIndividual, self.seed]

    def InitialPopulationGeneration(self):
        treeDepthTemp = self.max_depth - 1

        if treeDepthTemp <= 0:
            treeDepthTemp = 1

        numberOfTreesForEachDepth = self.pop_size // treeDepthTemp  # Math.floorDiv

        depthNumber = 1

        count = 0

        # Will generate trees using each method
        # METHOD_GROW will generate a full tree with the chance (ramped_half_half) to stop a branch from
        # generating a full branch and terminate with a terminal node
        # METHOD_FULL will generate a full tree given a specific depth
        for i in range(0, treeDepthTemp):
            for j in range(0, numberOfTreesForEachDepth // 2):
                self.population.append(self.GenerateTree(depthNumber, "METHOD_GROW"))
                count += 1
            for j in range(0, numberOfTreesForEachDepth // 2):
                self.population.append(self.GenerateTree(depthNumber, "METHOD_FULL"))
                count += 1
            depthNumber += 1

        # This is here just incase it does not generate the correct amount (strange pop_size provided)
        leftToGenerate = self.pop_size - count

        if leftToGenerate > 0:
            randTreeDepth = random.randint(1, self.max_depth)
            if random.random() < 0.5:
                self.population.append(self.GenerateTree(randTreeDepth, "METHOD_GROW"))
                count += 1
            else:
                self.population.append(self.GenerateTree(randTreeDepth, "METHOD_FULL"))
                count += 1

    """
        Will generate a tree, this starts out with the root, the root will always be a functional node
    """

    def GenerateTree(self, maxDepth, method) -> Individual:
        node = FunctionalNode("", [])

        children = []
        rand = random.random()

        if rand <= 0.25:
            node.setLabel("+")
        elif rand <= 0.50:
            node.setLabel("-")
        elif rand <= 0.75:
            node.setLabel("*")
        elif rand <= 1.0:
            node.setLabel("/")

        children.append(self.GenRndExpr(maxDepth - 1, method))
        children.append(self.GenRndExpr(maxDepth - 1, method))
        node.setChildren(children)

        individual = Individual(node, 100000.0)

        return individual

    """
        Recursive function that will generate the rest of the tree started in GenerateTree
    """

    def GenRndExpr(self, maxDepth, method) -> Node:
        if maxDepth == 0 or (method == "METHOD_GROW" and random.random() < self.ramped_half_half):
            node = TerminalNode("")
            rand = random.random()

            if rand <= 0.16:
                # Will make a constant between 0 and 1000 inclusive
                node.setLabel(str(float(random.randint(0, 1000))))
            elif rand <= 0.30:
                node.setLabel("Label")
            elif rand <= 0.44:
                node.setLabel("House")
            elif rand <= 0.58:
                node.setLabel("Year")
            elif rand <= 0.72:
                node.setLabel("Month")
            elif rand <= 0.86:
                node.setLabel("Temperature")
            elif rand <= 1.0:
                node.setLabel("Daylight")

            return node
        else:
            node = FunctionalNode("", [])

            children = []
            rand = random.random()

            if rand <= 0.25:
                node.setLabel("+")
            elif rand <= 0.50:
                node.setLabel("-")
            elif rand <= 0.75:
                node.setLabel("*")
            elif rand <= 1.0:
                node.setLabel("/")

            children.append(self.GenRndExpr(maxDepth - 1, method))
            children.append(self.GenRndExpr(maxDepth - 1, method))
            node.setChildren(children)

            return node

    """
        An interpreter that interprets a tree, will return a prediction.
    """

    def RunGP(self, individual, node, dataEntry) -> float:
        if re.findall(r"\d+", node.getLabel()):
            return node.getLabel()
        match node.getLabel():
            case "Label":
                return dataEntry.getLabel()
            case "House":
                return dataEntry.getHouse()
            case "Year":
                return dataEntry.getYear()
            case "Month":
                return dataEntry.getMonth()
            case "Temperature":
                return dataEntry.getTemperature()
            case "Daylight":
                return dataEntry.getDaylight()
            case "+":
                return float(self.RunGP(individual, node.getChildren()[0], dataEntry)) + float(
                    self.RunGP(individual, node.getChildren()[1],
                               dataEntry))
            case "-":
                return float(self.RunGP(individual, node.getChildren()[0], dataEntry)) - float(
                    self.RunGP(individual, node.getChildren()[1],
                               dataEntry))
            case "*":
                return float(self.RunGP(individual, node.getChildren()[0], dataEntry)) * float(
                    self.RunGP(individual, node.getChildren()[1],
                               dataEntry))
            case "/":
                # Check if the denominator is 0, can't divide by 0
                divisor = float(self.RunGP(individual, node.getChildren()[1], dataEntry))
                if divisor == 0:
                    return 100000.0
                else:
                    return float(self.RunGP(individual, node.getChildren()[0], dataEntry)) / float(divisor)
            case _:
                pass

    """
        Returns a random individual in matingPool
    """

    def FitnessProportionateSelection(self) -> Individual:
        return self.matingPool[random.randint(0, len(self.matingPool) - 1)]

    """
        Populates the matingPool list with individuals based on its normalisedFitness.
        An individual who has a better fitness has a higher chance of being picked in FitnessProportionateSelection
        because it occurs more in the mating pool list
    """

    def CreateFitnessProportionateSelection(self):
        for i in range(0, len(self.population)):
            self.population[i].setNormalisedFitness(self.population[i].getAdjustedFitness() / self.totalAdjusted)
            numberOfOccurrences = round(self.population[i].getNormalisedFitness() * self.pop_size)
            for j in range(0, numberOfOccurrences):
                self.matingPool.append(copy.deepcopy(self.population[i]))

    """
        Crossover will select 2 random individuals and 2 random points (one point in each individual).
        The subtrees at each point are then swapped.
        The resulting tree is added to the next population for teh next generation.
    """

    def CrossOver(self):
        parentOne = copy.deepcopy(self.FitnessProportionateSelection())
        parentTwo = copy.deepcopy(self.FitnessProportionateSelection())

        numNodesOne = parentOne.getRoot().CountNodes()
        numNodesTwo = parentTwo.getRoot().CountNodes()

        pointOne = random.randint(1, numNodesOne)
        pointTwo = random.randint(1, numNodesTwo)

        nodeOne = self.CrossOverHelper(parentOne.getRoot(), pointOne)
        nodeTwo = self.CrossOverHelper(parentTwo.getRoot(), pointTwo)

        nodeOneParent = self.CrossOverParentHelper(parentOne.getRoot(), nodeOne)
        nodeTwoParent = self.CrossOverParentHelper(parentTwo.getRoot(), nodeTwo)

        tempNodeOne = copy.deepcopy(nodeOne)
        tempNodeTwo = copy.deepcopy(nodeTwo)

        for i in range(0, len(nodeOneParent.getChildren())):
            if nodeOneParent.getChildren()[i].getLabel() == nodeOne.getLabel():
                nodeOneParent.getChildren()[i] = tempNodeOne
                break

        for i in range(0, len(nodeTwoParent.getChildren())):
            if nodeTwoParent.getChildren()[i].getLabel() == nodeTwo.getLabel():
                nodeTwoParent.getChildren()[i] = tempNodeTwo
                break

        parentOne.resetValues()
        parentTwo.resetValues()
        self.newPopulation.append(parentOne)
        self.newPopulation.append(parentTwo)

    """
        CrossOverHelper will return the node at the random point provided
    """

    def CrossOverHelper(self, node, point) -> Node:
        tempQueue = []

        if point == 1:
            if node.getChildren() is None:
                return node.getChildren()[0]
            else:
                return node

        tempQueue.append(node)
        while tempQueue:
            tempNode = tempQueue.pop(0)

            if point <= 1:
                #node = tempNode
                return node

            point -= 1

            if tempNode.getChildren():
                for i in range(0, len(tempNode.getChildren())):
                    tempQueue.append(tempNode.getChildren()[i])
        return None

    """
        CrossOverParentHelper will return the parent of the node returned in CrossOverHelper
    """

    def CrossOverParentHelper(self, nodeParent, node) -> Node:
        tempQueue = [nodeParent]

        while tempQueue:
            tempNode = tempQueue.pop(0)

            if tempNode == nodeParent:
                #nodeParent = tempNode
                return nodeParent

            if tempNode.getChildren():
                if node in tempNode.getChildren():
                    nodeParent = tempNode
                    return nodeParent
                for i in range(0, len(tempNode.getChildren())):
                    tempQueue.append(tempNode.getChildren()[i])

        return None

    """
        Mutation selects a random individual and a random point in the individual.
        A new subtree is generated and replaces the subtree at the random point.
    """

    def Mutation(self):
        parent = copy.deepcopy(self.FitnessProportionateSelection())

        numNodes = parent.getRoot().CountNodes()

        point = random.randint(1, numNodes)

        node = self.CrossOverHelper(parent.getRoot(), point)

        nodeParent = self.CrossOverParentHelper(parent.getRoot(), node)

        newSubTree = self.GenerateTree(self.max_depth, "METHOD_GROW")

        for i in range(0, len(nodeParent.getChildren())):
            if nodeParent.getChildren()[i].getLabel == node.getLabel():
                nodeParent.getChildren()[i] = newSubTree.getRoot()
                break

        parent.resetValues()

        self.newPopulation.append(parent)

    """
        Reproduction copies over a random individual from the old population to the next population.
    """

    def Reproduction(self):
        parent = copy.deepcopy(self.FitnessProportionateSelection())
        parent.resetValues()
        self.newPopulation.append(parent)
