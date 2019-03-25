class DatasController < ApplicationController
  before_action :set_house, only: [:index]

  def index
    @datas = @house.datasets.pluck(:Label, :Temperature, :Year, :Month, :Daylight, :EnergyProduction)
    @labels = @datas.map(&:first)
    @temperatures = @datas.map(&:second)
  end

  private
  def set_house
    @house = House.find(params[:user_id])
  end
end
