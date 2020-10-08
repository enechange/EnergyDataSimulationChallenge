class PlansController < ApplicationController
  def new
    @plan = Plan.new
    @providers = Provider.all
  end

  def create
    if Plan.create(plan_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name).merge(provider_id: params[:plan][:provider])
  end

end
