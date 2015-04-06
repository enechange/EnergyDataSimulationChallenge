class HousesController < ApplicationController
  def all
    @houses = House.order(:id)

    respond_to do |format|
      format.html
      format.csv { send_data @houses.as_csv }
    end
  end
end
