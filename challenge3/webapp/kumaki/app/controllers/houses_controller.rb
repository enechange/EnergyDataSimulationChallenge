class HousesController < ApplicationController
  def index
    @houses = House.includes(:city).page(params[:page]).per(10).order(:id)
  end

  def show
    @datasets = Dataset.includes(:house).search_with_house_id(params[:id]).order(:id)
    @average_dataset = Dataset.search_with_house_id(params[:id]).group(:house_id).select_average_dataset
    @houses = House.where(id: params[:id])
  end
end
