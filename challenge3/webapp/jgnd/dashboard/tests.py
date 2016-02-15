import csv
from django.test import TestCase
from models import House, Energy

# these should be split and put into a testing module

class HouseTestCase(TestCase):

  def setUp(self):
    House.objects.create(firstname='John', lastname='Smith', city='London', number_of_people=2, has_child=False)

  def test_fullname(self):
    house = House.objects.get(firstname='John')
    self.assertEqual('John Smith', house.fullname())

  def test_has_child_string(self):
    house = House.objects.get(firstname='John')
    self.assertEqual('No', house.has_child_string())


class ViewTestCase(TestCase):

  def setUp(self):
    h1 = House.objects.create(firstname='John', lastname='Smith', city='London', number_of_people=2, has_child=False)
    h2 = House.objects.create(firstname='Jane', lastname='Doe', city='Cambridge', number_of_people=4, has_child=False)

    Energy.objects.create(label=0, house=h1, year=2011, month=1, temperature=20, daylight=300, energy_production=500)
    Energy.objects.create(label=0, house=h2, year=2011, month=1, temperature=18, daylight=250, energy_production=300)
    Energy.objects.create(label=0, house=h1, year=2012, month=1, temperature=21, daylight=350, energy_production=600)
    Energy.objects.create(label=0, house=h2, year=2012, month=1, temperature=19, daylight=280, energy_production=500)



  def test_monthly_average_energy_production(self):
    response = self.client.get('/dashboard/monthly_average_energy_production')
    self.assertEqual(response.status_code, 200)
    csv_data = csv.reader(response, delimiter=',')

    next(csv_data)
    self.assertEqual(['Month', 'Average energy production'], next(csv_data))
    self.assertEqual(['1', '475.0'], next(csv_data))
    self.assertEqual(None, next(csv_data, None))

  def test_monthly_average_energy_production_and_daylight(self):
    response = self.client.get('/dashboard/monthly_average_energy_production_and_daylight')
    self.assertEqual(response.status_code, 200)
    csv_data = csv.reader(response, delimiter=',')
    next(csv_data)
    self.assertEqual(['Date', 'Average energy production', 'Average daylight'], next(csv_data))
    self.assertEqual(['2011-1', '400.0', '275.0'], next(csv_data))
    self.assertEqual(['2012-1', '550.0', '315.0'], next(csv_data))
    self.assertEqual(None, next(csv_data, None))

  def test_monthly_average_energy_production_and_temperature(self):
    response = self.client.get('/dashboard/monthly_average_energy_production_and_temperature')
    self.assertEqual(response.status_code, 200)
    csv_data = csv.reader(response, delimiter=',')
    next(csv_data)
    self.assertEqual(['Date', 'Average energy production', 'Average temperature'], next(csv_data))
    self.assertEqual(['2011-1', '400.0', '19.0'], next(csv_data))
    self.assertEqual(['2012-1', '550.0', '20.0'], next(csv_data))
    self.assertEqual(None, next(csv_data, None))

  def test_yearly_average_energy_production_by_city(self):
    response = self.client.get('/dashboard/yearly_average_energy_production_by_city')
    self.assertEqual(response.status_code, 200)
    csv_data = csv.reader(response, delimiter=',')
    next(csv_data)
    self.assertEqual(['City', '2011', '2012'], next(csv_data))
    self.assertEqual(['Cambridge', '300.0', '500.0'], next(csv_data))
    self.assertEqual(['London', '500.0', '600.0'], next(csv_data))
    self.assertEqual(None, next(csv_data, None))
