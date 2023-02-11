This submission is from Pavlo Andrianatos on the 11th February 2023

This submission was made using Pycharm 2022.1, Anaconda 4.13.0, and Python 3.10. A environment.yml file is provided to replicate the programming envvironment.

The program can be run by running Run_Script.bat, this will run Main.py

I opted to use Genetic Programming to solve challenge 1, this uses symbolic regression to obtain an optimal mathematical function that
predicts the EnergyProduction.

This involves generating trees that get interpreted and using the values for each ID (Label, House, Year, Month, Temperature, Daylight) will predict an
EnergyProduction.

There is a parameter.config file where parameters can be changed to alter the generation of solutions.

The parameters are as followed:

[Training]
filename = training_dataset_500.csv 	(Filename of training dataset)
random_seed = True						(If True the program will use a random seed)
seed = 123								(Seed to use during training, if random_seed is set to 1 the user-provided seed is ignored)
max_generations = 5						(Number of generations in each run, will perform crossover, mutation, and reproduction at the end of each generation)
pop_size = 10							(Number of trees in each generation)
max_depth = 4							(The max depth of trees, Mutation can cause a tree to exceed the max_depth. Recommended 2 - 6, can make it more 
										but the trees become quite big)
crossover_chance = 0.7					(Chance crossover will be used to create a new tree for the next generation)
mutation_chance = 0.2					(Chance mutation will be used to create a new tree for the next generation)
reproduction_chance = 0.1				(Chance reproduction will be used to create a new tree for the next generation. Don't recommend setting 
										this too high, because then you are just copying over the last population to the next. We want to apply
										selection pressure)
num_of_runs = 3							(Number of runs)
ramped_half_half = 0.5					(Chance a tree will stop generating a full tree and the generating branch terminates with a terminal node)

[Testing]
filename = test_dataset_500.csv 		(Filename of test dataset)

The fitness for each individual in the population is the MAPE for the individual given all training data and multiplied by 100. The best fitness is 0.

The fitness is used in fitness proportionate selection where random individual are selected out of a mating pool to be used in either crossover, mutation, or reproduction.

Crossover selects a random point on two different individuals and swaps the sub branches at those nodes.

Mutation selects a random point in an individual and generates a new sub tree at that point.

Reproduction copies over an individual from the old population into the new population.

Best Individual found:
- -
-- +
--- 557.0
--- Label
-- +
--- Label
--- Temperature
MAPE:  0.13358284671566079
Seed: 3054022391716465016

Best Individual parameters:
[Training]
filename = training_dataset_500.csv
random_seed = False
seed = 3054022391716465016
max_generations = 3
pop_size = 10
max_depth = 3
crossover_chance = 0.7
mutation_chance = 0.2
reproduction_chance = 0.1
num_of_runs = 3
ramped_half_half = 0.5

[Testing]
filename = test_dataset_500.csv