class DashboardController < ApplicationController
  def index
  end
  def show
    city_sum = HouseData.get_average_tempreture
    temperature_avg = DataSetSample.get_average_data
    render json: {city_sum: city_sum, temperature_avg: temperature_avg}
  end
end