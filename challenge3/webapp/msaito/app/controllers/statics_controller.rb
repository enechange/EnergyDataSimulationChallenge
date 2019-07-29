class StaticsController < ApplicationController
  before_action :search
  def index
    @houses = House.search(params).page(params[:page]).per(10)
  end

  def show
    @house = House.find(params[:id])
    @datas = @house.datasets.pluck(:year,:month, :temperature, :daylight, :energy_production)
    @dates = @house.datasets.pluck(:year,:month)
    @temperatures = @datas.map(&:third)
    @daylights = @datas.map(&:fourth)
    @energyproductions = @datas.map(&:fifth)
  end

 private

  def search
    @houses = House.search(params.permit!)
  end
end
