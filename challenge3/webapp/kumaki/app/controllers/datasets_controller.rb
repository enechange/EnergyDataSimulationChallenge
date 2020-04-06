class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.search_with_house_id(params[:house_id]).order(:id)
  end
end
