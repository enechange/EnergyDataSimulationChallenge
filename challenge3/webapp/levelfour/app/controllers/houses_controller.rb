class HousesController < ApplicationController
  def index
  end

  def edit
  end

  def new
  end

  def list
	  @houses = House.find(:all)
  end

  def detail
  end
end
