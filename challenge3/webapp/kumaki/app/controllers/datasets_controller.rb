class DatasetsController < ApplicationController
  def index
    @datasets_group_by_time = Dataset.select_average_datasets_group_by(:year_month)
    @average_dataset = Dataset.select_average_dataset
    @datasets = Dataset.order(:id)
    @datasets_for_pagination = @datasets.includes(:house).page(params[:page]).per(50)
  end
end
