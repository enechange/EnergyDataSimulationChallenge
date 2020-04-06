class HousesController < ApplicationController
  def index
    @houses = House.includes(:city).page(params[:page]).per(10).order(:id)
  end
end
