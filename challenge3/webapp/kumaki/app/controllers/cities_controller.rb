class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @cities = City.where(id: params[:id])
    @datasets = Dataset.joins(house: :city).where(cities: {id: params[:id]})
                      .select_average_datasets_group_by(:year_month)
  end
end
