class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @cities = City.where(id: params[:id])
    @datasets = Dataset.search_with_city_id(params[:id])
                      .select_average_datasets_group_by(:year_month)
    @average_dataset = Dataset.search_with_city_id(params[:id]).select_average_dataset
  end
end
