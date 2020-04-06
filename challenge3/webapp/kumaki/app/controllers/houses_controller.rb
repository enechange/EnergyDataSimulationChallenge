class HousesController < ApplicationController
  def index
    @houses = House.includes(:city).page(params[:page]).per(10).order(:id)
  end

  def show
    @datasets = Dataset.search_with_house_id(params[:id]).order(:id)
    @data_for_chart = []
    @datasets.each do |dataset|
      @data_for_chart << [dataset.date, dataset.energy_production]
    end
  end
end
