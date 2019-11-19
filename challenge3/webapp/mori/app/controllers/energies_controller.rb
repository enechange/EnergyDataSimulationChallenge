class EnergiesController < ApplicationController
  
  def index
  end

  def create
    @energy = Energy.new(energy_params)
    
    if @energy.save
      flash[:success] = 'create Energy!!'
      redirect_to @house
    else
      flash[:danger] = 'not create Energy...'
      redirect_to houses_url
    end
  end
  
  private
    def energy_params
      params.require(:energy).permit(:label, :house_id, :year, :month, :temperature, :daylight, :energy_params)
    end
end
