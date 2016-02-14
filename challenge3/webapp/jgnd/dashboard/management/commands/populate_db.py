import csv
from django.core.management.base import BaseCommand
from dashboard.models import House, Energy


class Command(BaseCommand):
  args = ''
  help = 'load data from CSV files'

  def _create_data_from_csvs(self):
    Energy.objects.all().delete()
    House.objects.all().delete()
    with open('../../data/house_data.csv') as f:
      reader = csv.reader(f, delimiter=',')
      header = next(reader)
      House.objects.bulk_create([House(id=row[0], firstname=row[1], lastname=row[2], city=row[
                                3], number_of_people=row[4], has_child=(row[5] == 'Yes')) for row in reader])
    with open('../../data/dataset_50.csv') as f:
      reader = csv.reader(f, delimiter=',')
      header = next(reader)
      Energy.objects.bulk_create([Energy(id=row[0], label=row[1], house_id=row[2], year=row[3], month=row[
                                 4], temperature=row[5], daylight=row[6], energy_production=row[7]) for row in reader])

  def handle(self, *args, **options):
    self._create_data_from_csvs()
