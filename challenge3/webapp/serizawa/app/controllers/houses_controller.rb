class HousesController < ApplicationController
  def index
    @houses = House.all
  end
  
  def show
    @house = House.find(params[:id])
  end
  
  def new
    @house = House.new
  end
  
  def edit
    @house = House.find(params[:id])
  end

  def create
    @house = House.new(house_params) 
    if @house.save
      redirect_to @house
    else
      render 'new'
    end
  end
  
  def destroy
    @house = House.find(params[:id])
    @house.destroy
    redirect_to root_path 
  end
  
  private 
  
    def house_id_params
      params.require(:house).permit(:id)
    end
  
    def house_params
      params.require(:house).permit(:firstname, :lastname, :city, :num_of_people, :has_child)
    end
end
