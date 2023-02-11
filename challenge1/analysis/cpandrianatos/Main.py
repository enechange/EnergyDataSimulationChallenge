from Genetic_Program import Genetic_Program
from Individual import Individual
from LoadParameters import LoadParameters
from OutputPredictions import OutputPredictions

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""

if __name__ == "__main__":
    # Load Parameters
    lp = LoadParameters()
    lp.ReadInParameters()

    fileName = lp.fileNameTrain
    seed = lp.seed
    max_generations = lp.max_generations
    pop_size = lp.pop_size
    max_depth = lp.max_depth
    crossover_chance = lp.crossover_chance
    mutation_chance = lp.mutation_chance
    reproduction_chance = lp.reproduction_chance
    num_of_runs = lp.num_of_runs
    ramped_half_half = lp.ramped_half_half
    random_seed = lp.random_seed

    # List to store the best individual for each run
    data_from_runs = []

    for i in range(0, num_of_runs):
        gp = Genetic_Program()
        data_from_runs.append(gp.Perform_Run(fileName, seed, max_generations, pop_size, max_depth, crossover_chance,
                                             mutation_chance, reproduction_chance, ramped_half_half, random_seed))
        # This is mainly if you want to have an increasing seed each run, otherwise using a static seed will
        # result in the same outcome every run
        seed += 10

    # The best individual is obtained from all runs and sent to the OutputEneryPredictions class
    bestIndividual: Individual
    bestIndividualFitness = 100000.0
    bestIndex = -1
    for i in range(0, len(data_from_runs)):
        if data_from_runs[i][0].getFitness() < bestIndividualFitness:
            bestIndividualFitness = data_from_runs[i][0].getFitness()
            bestIndex = i

    bestIndividual = data_from_runs[bestIndex][0]
    bestSeed = data_from_runs[bestIndex][1]

    op = OutputPredictions()

    op.OutputEneryPredictions(lp, bestIndividual, bestSeed)
