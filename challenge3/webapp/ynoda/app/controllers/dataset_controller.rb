class DatasetController < ApplicationController
  protect_from_forgery
  def show
    @dataset = Dataset.order(:id)
  end
end
