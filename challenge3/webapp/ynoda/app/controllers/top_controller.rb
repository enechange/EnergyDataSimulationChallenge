class TopController < ApplicationController
  def index
      @dataset = Dataset.order(:id)
      @houses = Housedata.order(:house)
  end
end
