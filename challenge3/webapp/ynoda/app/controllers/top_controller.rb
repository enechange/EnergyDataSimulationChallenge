class TopController < ApplicationController
  def index
      @energylog = Energylog.order(:id)
      @houses = House.order(:house)
  end
end
