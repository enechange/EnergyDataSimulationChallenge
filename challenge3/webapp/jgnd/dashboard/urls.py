from django.conf.urls import url

from . import views

urlpatterns = [
    url(r'^house/list$', views.list_houses),
    url(r'^house/([0-9]+)$', views.show_house),
    url(r'^house/([0-9]+)/energy_production$', views.house_energy_production),
    url(r'^house/([0-9]+)/daylight$', views.house_daylight),
    url(r'^house/([0-9]+)/temperature$', views.house_temperature),

    url(r'^highest_and_lowest_average_energy_producers$', views.highest_and_lowest_average_energy_producers,
        name='highest_and_lowest_average_energy_producers'),
    url(r'^monthly_average_energy_production$', views.monthly_average_energy_production,
        name='monthly_average_energy_production'),
    url(r'^monthly_average_energy_production_and_daylight$', views.monthly_average_energy_production_and_daylight,
        name='monthly_average_energy_production_and_daylight'),
    url(r'^monthly_average_energy_production_and_temperature$', views.monthly_average_energy_production_and_temperature,
        name='monthly_average_energy_production_and_temperature'),
    url(r'^yearly_average_energy_production_by_city$', views.yearly_average_energy_production_by_city,
        name='yearly_average_energy_production_by_city'),

    url(r'^$', views.index, name='index')
]
