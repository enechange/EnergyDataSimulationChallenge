
class BasicChargesController < ApplicationController
  def new
    @basic_charge = BasicCharge.new
    @plans = Plan.all.includes(:provider)
  end

  def create
    if BasicCharge.create(basic_charge_params)
      redirect_to new_basic_charge_path
    else
      render :new
    end
  end

  private

  def basic_charge_params
    params.require(:basic_charge).permit(:current, :charge).merge(plan_id: params[:basic_charge][:plan])
  end

end
