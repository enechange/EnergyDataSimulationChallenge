class PowerConsumptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params, only: [:edit, :update, :destroy]

  def index
    @power_consumptions = PowerConsumption.where(user_id: current_user.id)
  end

  def new
    @power_consumption = PowerConsumption.new
  end

  def create
    @power_consumption = PowerConsumption.new(power_consumption_params)
    @power_consumption.user_id = current_user.id
    if @power_consumption.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @power_consumption.update(update_params)
      redirect_to power_consumptions_path
    else
      render :edit
    end
  end

  def destroy
    if @power_consumption.destroy
      redirect_to power_consumptions_path
    else
      redirect_to power_consumptions_path
      :javascript
        alert('削除できませんでした。');
    end
  end

  private

  def power_consumption_params
    params.require(:power_consumption).permit(
      :power_consumption,
      :year,
      :month
    )
  end

  def set_params
    @power_consumption = PowerConsumption.find(params[:id])
  end

  def update_params
    params.require(:power_consumption).permit(
      :power_consumption,
      :year,
      :month
    )
  end
end
