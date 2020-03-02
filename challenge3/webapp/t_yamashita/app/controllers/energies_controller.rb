class EnergiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @energy = Energy.new
  end

  def create
    @energy = Energy.new(energy_params)
    @energy.user_id = current_user.id

    if @energy.save
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def energy_params
    params.require(:energy).permit(
      :user_id,
      :year,
      :month,
      :temperature,
      :daylight,
      :energy_production
    )
  end
end