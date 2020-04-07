class HousesController < ApplicationController
  def index
    @houses_group_by_city = House.count_city
    @houses_num_of_people = House.count_num_of_people
    @houses_has_child = House.count_has_child
    @houses_for_pagination = House.includes(:city).page(params[:page]).per(10).order(:id)
  end

  def show
    @datasets = Dataset.includes(:house).search_with_house_id(params[:id]).order(:id)
    @average_dataset = Dataset.search_with_house_id(params[:id]).group(:house_id).select_average_dataset
    @houses = House.where(id: params[:id])
  end
end
