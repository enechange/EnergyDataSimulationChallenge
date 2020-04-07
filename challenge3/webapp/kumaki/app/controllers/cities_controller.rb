class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @cities = City.where(id: params[:id])
    @datasets_group_by_time = Dataset.search_with_city_id(params[:id])
                                     .select_average_datasets_group_by(:year_month)
    @average_dataset = Dataset.search_with_city_id(params[:id]).select_average_dataset
    @datasets = Dataset.search_with_city_id(params[:id]).includes(:house)
    @datasets_for_pagination = @datasets.page(params[:page]).per(10)
  end
end
