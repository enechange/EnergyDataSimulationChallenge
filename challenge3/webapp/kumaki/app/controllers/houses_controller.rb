class HousesController < ApplicationController
  def index
    @houses = House.includes(:city)
  end
end
