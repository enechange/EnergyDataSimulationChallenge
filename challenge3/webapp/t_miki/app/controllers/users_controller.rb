class UsersController < ApplicationController
  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
  end
end
