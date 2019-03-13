class EnergiesController < ApplicationController
  def index
    @energies = Energy.all
  end

  def show
     @energy = Energy.find(params[:id])
  end
  
  def new
     @energy = Energy.new
  end
  
  def create
     @energy = Energy.new(energy_params) 
    if  @energy.save
      redirect_to @energy
    else
      render 'new'
    end
  end
  
  def edit
    @energy =Energy.find(params[:id])
  end
  
  def update
    @energy = Energy.find(params[:id])
    if  @energy.update_attributes(energy_params)
      redirect_to  @energy
    else
      render 'edit'
    end
  end
  
  def destroy
    @energy = Energy.find(params[:id])
    @energy.destroy
    redirect_to energies_path 
  end
  
  private 
  #Strong Parameters
    def energy_params
      params.require(:energy).permit(:label, :house_id, :year, :month, :temperature,:daylight,:energy_production)
    end
end

