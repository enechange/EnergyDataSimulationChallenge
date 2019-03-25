class DatasController < ApplicationController
  before_action :set_house, only: [:index]

  def index
    @datas = @house.datasets.pluck(:Month, :Temperature, :Daylight, :EnergyProduction)
    @months = @datas.map(&:first)
    @temperatures = @datas.map(&:second)
    @daylights = @datas.map(&:third)
    @energyproductions = @datas.map(&:fourth)
  end

  private
  def set_house
    @house = House.find(params[:user_id])
  end
end
