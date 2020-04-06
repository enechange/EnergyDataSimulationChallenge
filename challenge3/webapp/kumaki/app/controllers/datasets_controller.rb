class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.search_with_house_id(params[:house_id]).order(:id)
    @data_for_chart = []
    @datasets.each do |dataset|
      @data_for_chart << [dataset.date, dataset.energy_production]
    end
  end
end
