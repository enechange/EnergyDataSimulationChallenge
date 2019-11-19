require "city_energy.rb"

class CitiesController < ApplicationController
  def index
    @city = City.new
    @cities_name = City.all
    @cities_energy = CityEnergy.sum_cities_energy()
    @energy_count = CityEnergy.group('city_id').count
    @name = []
    @data = []
    @cities_name.each do |d|
      @name << d.name
      @data << @cities_energy[d.id]
    end
    @city_graph = city_hight_chart(@name, @data)
  end
  
  
  def create
    @city = City.new(city_params)
    if @city.save
      flash[:success] = 'Create City!!'
      redirect_to root_url
    else
      flash.now[:danger] = 'Not Create City...'
      render root_url
    end
  end
  
  
  private
  
  def city_params
    params.require(:city).permit(:name)
  end
  
  def city_hight_chart(locations, energy_production)
    @chart = LazyHighCharts::HighChart.new("graph") do |c|
      c.title(text: "Total Energy Production")
      c.xAxis(categories: locations)
      c.series(name: "Energy Production", data: energy_production)
      c.chart(type: "column", backgroundColor: 'lightgray')
    end
  end
end
