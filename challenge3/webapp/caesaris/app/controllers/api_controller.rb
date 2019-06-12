class ApiController < ApplicationController

  def city_list
    @city_list = City.all.select(:id, :name).order(:id)
    render json: @city_list
  end

end
