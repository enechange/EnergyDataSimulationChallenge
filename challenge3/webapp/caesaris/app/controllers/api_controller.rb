class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def city_list
    @city_list = City.all.select(:id, :name).order(:id)
    render json: @city_list
  end

end
