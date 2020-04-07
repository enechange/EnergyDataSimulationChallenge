class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @cities = City.where(id: params[:id])
    @datasets = Dataset.joins(house: :city).where(cities: {id: params[:id]}).select('datasets.year_month, AVG(datasets.temperature) AS temperature, AVG(datasets.daylight) AS daylight, AVG(datasets.energy_production) AS energy_production').group(:year_month).order(:year_month)
  end
end
