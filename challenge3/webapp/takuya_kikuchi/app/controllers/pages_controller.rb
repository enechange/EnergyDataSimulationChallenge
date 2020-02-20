class PagesController < ApplicationController
  def main
    year_month_energy = Dataset.group(:year,:month).sum(:energy_production)
    year_month_temperature = Dataset.group(:year,:month).average(:temperature)
    year_month_daylight = Dataset.group(:year,:month).average(:daylight)
    # Bar-chart x-axis
    gon.year_months = year_month_energy.keys.sort
    # Bar-chart y-axis
    gon.production = year_month_energy.values
    gon.temperature = year_month_temperature.values
    gon.daylight = year_month_daylight.values
  end
end
