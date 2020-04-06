class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all.page(params[:page]).per(100).order(:id)
  end
end
