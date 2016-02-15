import csv
from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from django.db.models import Avg, Sum
from models import Energy, House

limit = 5


def index(request):
  highest_producing_houses = House.objects.annotate(average_energy_production=Avg(
      'energy__energy_production')).order_by('-average_energy_production')[:limit]
  lowest_producing_houses = House.objects.annotate(average_energy_production=Avg(
      'energy__energy_production')).order_by('average_energy_production')[:limit]

  context = {
      'highest_producing_houses': highest_producing_houses,
      'lowest_producing_houses': lowest_producing_houses
  }
  return render(request, 'index.html', context)


def list_houses(request):
  # this should have pagination
  houses = House.objects.annotate(average_energy_production=Avg('energy__energy_production'), average_daylight=Avg(
      'energy__daylight'), average_temperature=Avg('energy__temperature'))
  context = {
      'houses': houses
  }
  return render(request, 'list.html', context)


def show_house(request, id):
  house = get_object_or_404(House, id=id)
  context = {
      'house': house
  }
  return render(request, 'show.html', context)


def house_energy_production(request, id):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.filter(house__id=id).values(
      'year', 'month', 'energy_production').order_by('year', 'month')
  writer.writerow(['date', 'energy_production'])
  for d in data:
    writer.writerow([str(d['year']) + '-' + str(d['month']),
                     round(d['energy_production'], 2)])

  return response


def house_daylight(request, id):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.filter(house__id=id).values(
      'year', 'month', 'daylight').order_by('year', 'month')
  writer.writerow(['date', 'daylight'])
  for d in data:
    writer.writerow(
        [str(d['year']) + '-' + str(d['month']), round(d['daylight'], 2)])

  return response


def house_temperature(request, id):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.filter(house__id=id).values(
      'year', 'month', 'temperature').order_by('year', 'month')
  writer.writerow(['date', 'temperature'])
  for d in data:
    writer.writerow([str(d['year']) + '-' + str(d['month']),
                     round(d['temperature'], 2)])

  return response


def highest_and_lowest_average_energy_producers(request):
  highest_producing_houses = Energy.objects.values('house__id').annotate(total_energy_production=Avg(
      'energy_production')).order_by('-total_energy_production')[:limit]
  lowest_producing_houses = Energy.objects.values('house__id').annotate(total_energy_production=Avg(
      'energy_production')).order_by('total_energy_production')[:limit]
  ids = [h['house__id'] for h in highest_producing_houses] + [h['house__id']
                                                              for h in lowest_producing_houses]

  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.filter(house__id__in=ids).values(
      'house__id', 'year', 'month', 'energy_production').order_by('house__id', 'year', 'month')

  ### reformatting the data ###
  # the graph library can't use a column data for groups
  # - i.e. an ID column rather than a row for each house ID
  # (however it could be rearranged in javascript using d3.nest)

  house_data = {}
  for d in data:
    date_string = str(d['year']) + '-' + str(d['month'])
    if not house_data.has_key(date_string):
      house_data[date_string] = {}
    house_data[date_string][d['house__id']] = round(d['energy_production'], 2)

  writer.writerow(['Date'] + ids)
  for date, house_energy_production in house_data.iteritems():
    r = [date]
    for house_id in ids:
      r.append(house_energy_production[house_id])
    writer.writerow(r)
  return response


def monthly_average_energy_production(request):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.values('month').annotate(
      average_energy_production=Avg('energy_production')).order_by('month')
  writer.writerow(['Month', 'Average energy production'])
  for d in data:
    writer.writerow([d['month'], round(d['average_energy_production'], 2)])

  return response


def monthly_average_energy_production_and_daylight(request):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.values('year', 'month').annotate(average_energy_production=Avg(
      'energy_production'), average_daylight=Avg('daylight')).order_by('year', 'month')
  writer.writerow(['Date', 'Average energy production', 'Average daylight'])
  for d in data:
    writer.writerow([str(d['year']) + '-' + str(d['month']),
                     round(d['average_energy_production'], 2), round(d['average_daylight'], 2)])

  return response


def monthly_average_energy_production_and_temperature(request):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  data = Energy.objects.values('year', 'month').annotate(average_energy_production=Avg(
      'energy_production'), average_temperature=Avg('temperature')).order_by('year', 'month')
  writer.writerow(['Date', 'Average energy production', 'Average temperature'])
  for d in data:
    writer.writerow([str(d['year']) + '-' + str(d['month']), round(
        d['average_energy_production'], 2), round(d['average_temperature'], 2)])

  return response


def yearly_average_energy_production_by_city(request):
  response = HttpResponse(content_type='text/csv')
  writer = csv.writer(response)

  years = list(Energy.objects.values_list(
      'year', flat=True).order_by('year').distinct())
  cities = list(House.objects.values_list(
      'city', flat=True).order_by('city').distinct())

  data = Energy.objects.values('house__city', 'year').annotate(
      average_energy_production=Avg('energy_production')).order_by('house__city')

  ### reformatting the data ###
  # the graph library can't use a column data for groups
  # - i.e. a year column rather than a row for each year
  # (however it could be rearranged in javascript using d3.nest)

  city_data = {}
  for c in cities:
    city_data[c] = {}

  for d in data:
    city_data[d['house__city']][d['year']] = round(
        d['average_energy_production'], 2)

  writer.writerow(['City'] + years)
  for city, year_data in city_data.iteritems():
    r = [city]
    for year in years:
      if year_data.has_key(year):
        r.append(year_data[year])
    writer.writerow(r)

  return response
