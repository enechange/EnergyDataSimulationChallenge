class HousesController < ApplicationController
  skip_before_filter :verify_authenticity_token ,:only=>[:add]

  def index
  end

  def edit
  end

  def new
  end

  def add
    house = House.new
    house.first_name = params[:first_name]
    house.last_name = params[:last_name]
    house.city = params[:city]
    house.num_of_people = params[:num_of_people]
    house.has_child = params[:has_child]
    house.save

    flash[:success] = "new house added successfully"
    redirect_to :action => "list"
  end

  def list
	  @houses = House.find(:all)
  end

  def detail
  end
end
