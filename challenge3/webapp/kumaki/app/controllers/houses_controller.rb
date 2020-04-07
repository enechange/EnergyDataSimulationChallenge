class HousesController < ApplicationController
  def index
    @houses = House.includes(:city).page(params[:page]).per(10).order(:id)
  end

  def show
    @datasets = Dataset.includes(:house).search_with_house_id(params[:id]).order(:id)
    @average_dataset = Dataset.search_with_house_id(params[:id]).select('AVG(datasets.temperature) AS temperature, AVG(datasets.daylight) AS daylight, AVG(datasets.energy_production) AS energy_production').group(:house_id).take
    @houses = House.where(id: params[:id])
  end
end
