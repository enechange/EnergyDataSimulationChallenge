
class UsageChargesController < ApplicationController
  def new
    @usage_charge = UsageCharge.new
    @plans = Plan.all.includes(:provider)
  end

  def create
    if UsageCharge.create(usage_charge_params)
      redirect_to new_usage_charge_path
    else
      render :new
    end
  end

  private

  def usage_charge_params
    params.require(:usage_charge).permit(:lower_power, :upper_power, :charge).merge(plan_id: params[:usage_charge][:plan])
  end

end
