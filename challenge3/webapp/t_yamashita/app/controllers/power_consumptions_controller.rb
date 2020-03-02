class PowerConsumptionsController < ApplicationController
  before_action :authenticate_user!

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
  end

  def destroy
  end

  private

  def power_consumption_params
    params.require(:power_consumption).permit(
      :power_consumption,
      :year,
      :month
    )
  end
end
