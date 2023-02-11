import csv
from DataEntry import DataEntry

"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class DataReader:
    fileName: str

    """
        The data reader will read the data in either the training set or test set, whichever the user provides
    """

    def __init__(self, fileName):
        self.fileName = fileName

    def ReadInData(self) -> list:
        data = []
        with open("../../data/" + self.fileName) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=',')
            line_count = 0
            for row in csv_reader:
                if line_count == 0:
                    line_count += 1
                else:
                    data.append(DataEntry(row[0], row[1], row[2], row[3], row[4], row[5], row[6], row[7]))
                    line_count += 1
        return data
