"""
    @author Pavlo Andrianatos
    Date: 11/02/2023
"""


class DataEntry:
    ID: float
    Label: float
    House: float
    Year: float
    Month: float
    Temperature: float
    Daylight: float
    EnergyProduction: float

    """
        Each data entry represents one row in the dataset
    """
    def __init__(self, id_num, label, house, year, month, temperature, daylight, energy_production):
        self.ID = id_num
        self.Label = label
        self.House = house
        self.Year = year
        self.Month = month
        self.Temperature = temperature
        self.Daylight = daylight
        self.EnergyProduction = energy_production

    def getID(self):
        return self.ID

    def getLabel(self):
        return self.Label

    def getHouse(self):
        return self.House

    def getYear(self):
        return self.Year

    def getMonth(self):
        return self.Month

    def getTemperature(self):
        return self.Temperature

    def getDaylight(self):
        return self.Daylight

    def getEnergyProduction(self):
        return self.EnergyProduction
