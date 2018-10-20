class DashboardController < ApplicationController
  def index
  end
  def show
    city_sum = HouseData.group(:city).sum(:num_of_people)
    temperature_avg = DataSetSample.group(:year).average(:temperature)
    render json: {city_sum: city_sum, temperature_avg: temperature_avg}
  end
end
