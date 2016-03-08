class PlansController < ApplicationController
  def calculate
    plans = Plans::Loader.load
    plans.usage = usage_param
    render json: plans
  end

  private

    def usage_param
      params.require :usage
    end

end
