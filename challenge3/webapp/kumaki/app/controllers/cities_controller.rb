class CitiesController < ApplicationController
  def index
    @cities = City.all
  end

  def show
    @cities = City.where(id: params[:id])
  end
end
