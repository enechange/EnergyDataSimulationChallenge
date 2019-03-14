class HousesController < ApplicationController
 before_action :existence_of_house_id, only: [:show, :edit, :update, :destroy]

  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
    energy_chart = Energy.where(house_id: @house.id)
    @chart = chart(energy_chart)
  end
  
  def new
    @house = House.new
  end
  
  def create
    @house = House.new(house_params) 
    if @house.save
      redirect_to @house
    else
      render 'new'
    end
  end
  
  def edit
    @house = House.find(params[:id])
  end
  
  def update
    @house = House.find(params[:id])
    if @house.update_attributes(house_params)
      redirect_to @house
    else
      render 'edit'
    end
  end
  
  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to root_path 
  end
  
  private 
  
  #Strong Parameters
    def house_params
      params.require(:house).permit(:firstname, :lastname, :city, :num_of_people, :has_child)
    end
    
    def existence_of_house_id
      if House.find_by(id: params[:id]).nil?
         redirect_to(root_url)
      end
    end
end
