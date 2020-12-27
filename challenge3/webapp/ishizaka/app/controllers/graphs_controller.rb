class GraphsController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    @name = @house.first_name + ' ' + @house.last_name
    @datas = @house.datasets.pluck(:temperature, :daylight, :energy_production)
    @temperatures = @datas.map(&:first)
    @daylight = @datas.map(&:second)
    @energy_production = @datas.map(&:third)
    @dates = @house.datasets.pluck(:year, :month)
  end
end
