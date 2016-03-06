class PlansController < ApplicationController
  def calculate
    plans = Plans::Loader.load
    plans.usage = usage_data
    render json: plans
  end

  private

    def data_param
    end

    def usage_data
      [([0.1] * 24)] * 30
    end
end
