class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.includes(:house).page(params[:page]).per(100).order(:id)
  end
end
