class HousesController < ApplicationController

  def index
    @houses = House.all
    @data = Datum.pluck(:daylight, :energy_production)
    @city_energy_production = Datum.city_energy_production
  end

  def show
    @house = House.find(params[:id])
    @data = @house.data
    @output_data = []
    @energyProduction_perMonth = []
    daylight_perMonth = []
    temperature_perMonth = []
    @data.each do |d|
      @energyProduction_perMonth << [d.month_of_year, d.energy_production]
      daylight_perMonth << [d.month_of_year, d.daylight]
      temperature_perMonth << [d.month_of_year, d.temperature.to_f]
    end
    @output_data.push(
    {name: "日照エネルギー", data: daylight_perMonth},
    {name: "エネルギー産出量", data: @energyProduction_perMonth},
    {name: "気温", data: temperature_perMonth})
  end

end
