class HousesController < ApplicationController
  def index
    @houses = House.all
  end
  
  
end
