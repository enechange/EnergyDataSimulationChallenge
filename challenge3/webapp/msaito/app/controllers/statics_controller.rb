class StaticsController < ApplicationController
  
  def index
    @houses = House.page(params[:page]).per(10)
  end

  def show
    @house = House.find(params[:id])
    @datas = @house.datasets.pluck(:year,:month, :temperature, :daylight, :energy_production)
    @dates = @house.datasets.pluck(:year,:month)
    @temperatures = @datas.map(&:third)
    @daylights = @datas.map(&:fourth)
    @energyproductions = @datas.map(&:fifth)
  end

end
