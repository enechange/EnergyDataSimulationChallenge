import configparser

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class LoadParameters:
    fileNameTrain: str
    random_seed: bool
    seed: int
    max_generations: int
    pop_size: int
    max_depth: int
    crossover_chance: float
    mutation_chance: float
    reproduction_chance: float
    num_of_runs: int
    ramped_half_half: float
    fileNameTest: str

    """
        Using config parser, parameters are read in using the parameters.config file.
        These parameters are saved above and are accessed throughout the program.
    """
    def ReadInParameters(self):
        config = configparser.ConfigParser()

        config.read("parameters.config")
        self.fileNameTrain = config["Training"]["filename"]
        self.random_seed = True if config["Training"]["random_seed"] == "True" else False
        self.seed = int(config["Training"]["seed"])
        self.max_generations = int(config["Training"]["max_generations"])
        self.pop_size = int(config["Training"]["pop_size"])
        self.max_depth = int(config["Training"]["max_depth"])
        self.crossover_chance = float(config["Training"]["crossover_chance"])
        self.mutation_chance = float(config["Training"]["mutation_chance"])
        self.reproduction_chance = float(config["Training"]["reproduction_chance"])
        self.num_of_runs = int(config["Training"]["num_of_runs"])
        self.ramped_half_half = float(config["Training"]["ramped_half_half"])

        self.fileNameTest = config["Testing"]["filename"]
