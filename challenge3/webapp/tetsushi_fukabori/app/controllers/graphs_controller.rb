class GraphsController < ApplicationController
  before_action :ensure_json_request, only: [ :scatter, :line ]

  def index
    @keys = (Energy::SCATTER_KEY_LIST + Energy::LINE_KEY_LIST).uniq
  end

  def scatter
    render json: Energy.scatter_data(scatter_params[:key]), status: :ok
  end

  def line
    render json: Energy.line_data(line_params[:key]), status: :ok
  end

  private

  def scatter_params
    params.permit(:key)
  end

  def line_params
    params.permit(:key)
  end

  def ensure_json_request
    return if request.format == :json

    head :not_acceptable
  end
end
