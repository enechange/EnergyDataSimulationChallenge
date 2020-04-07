class DatasetsController < ApplicationController
  def index
    @datasets_group_by_time = Dataset.select('datasets.year_month, AVG(datasets.temperature) AS temperature, AVG(datasets.daylight) AS daylight, AVG(datasets.energy_production) AS energy_production').group(:year_month).order(:year_month)
    @datasets = Dataset.order(:id)
    @datasets_for_pagination = @datasets.includes(:house).page(params[:page]).per(50)
  end
end
