class ApiController < ApplicationController
  # skip_before_action :verify_authenticity_token
  before_action :authenticate_user!, except: [:city_list, :default_user]

  def city_list
    @city_list = City.all.select(:id, :name).order(:id)
    render json: @city_list
  end

  def default_user
    if EasySettings.default_user.show
      render json: EasySettings.default_user
    else
      render json: {}
    end
  end

  def user_info
    user = current_user
    render json: {
      roles: user.roles,
      avatar: user.img_url,
      name: user.name
    }
  end
end
