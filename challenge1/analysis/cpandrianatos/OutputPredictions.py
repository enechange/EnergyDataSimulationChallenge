import csv
from DataReader import DataReader
from Genetic_Program import Genetic_Program

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class OutputPredictions:
    """
        The best individual is used to calculate the EnergyProduction for each house in the test dataset.
        The Mean Absolute Percentage Error (MAPE) is calculated and output to a txt file.
        The predictions are saved in the predicted_energy_production.csv file
    """
    def OutputEneryPredictions(self, lp, bestIndividual, bestSeed):
        fileNameTest = lp.fileNameTest

        dr = DataReader(fileNameTest)

        data = dr.ReadInData()

        gpTest = Genetic_Program()

        testFitness = 0.0

        output_house_energy = []

        for i in range(0, len(data)):
            prediction = gpTest.RunGP(bestIndividual, bestIndividual.getRoot(), data[i])

            testFitness += abs(
                (float(data[i].getEnergyProduction()) - prediction) / float(data[i].getEnergyProduction()))

            tempOutput = [data[i].getHouse(), data[i].getEnergyProduction()]
            output_house_energy.append(tempOutput)

        testFitness = testFitness * (1 / len(data))

        bestIndividual.printTree(bestIndividual.getRoot(), "-")

        print("MAPE: ", testFitness)
        print("Seed: ", bestSeed)

        header = ["House", "EnergyProduction"]

        with open("predicted_energy_production.csv", "w", encoding='UTF8', newline='') as CSV_file:
            writer = csv.writer(CSV_file)
            writer.writerow(header)
            writer.writerows(output_house_energy)

        with open("mape.txt", "w", encoding='UTF8', newline='') as MAPE_txt:
            MAPE_txt.write(str(testFitness))
