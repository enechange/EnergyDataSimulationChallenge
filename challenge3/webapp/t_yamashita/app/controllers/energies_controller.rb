class EnergiesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: [:edit, :update, :destroy]

  def index
    @energies = Energy.where(user_id: current_user.id)
  end

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

  def edit
  end

  def update
    if @energy.update(update_params)
      redirect_to energies_path
    else
      render :edit
    end
  end

  def destroy
    if @energy.destroy
      redirect_to energies_path
    else
      redirect_to energies_path
      :javascript
        alert('削除できませんでした。');
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

  def set_params
    @energy = Energy.find(params[:id])
  end

  def update_params
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