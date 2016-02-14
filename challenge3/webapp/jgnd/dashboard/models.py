from __future__ import unicode_literals

from django.db import models


class House(models.Model):
  firstname = models.CharField(max_length=200)
  lastname = models.CharField(max_length=200)
  city = models.CharField(max_length=200)
  number_of_people = models.IntegerField()
  has_child = models.BooleanField()

  def fullname(self):
    return self.firstname + " " + self.lastname

  def has_child_string(self):
    if self.has_child:
      return 'Yes'
    else:
      return 'No'

  def get_absolute_url(self):
    return "/dashboard/house/%i" % self.id


class Energy(models.Model):
  label = models.IntegerField()
  house = models.ForeignKey(House, on_delete=models.CASCADE)
  year = models.IntegerField()
  month = models.IntegerField()
  temperature = models.FloatField()
  daylight = models.FloatField()
  energy_production = models.FloatField()
