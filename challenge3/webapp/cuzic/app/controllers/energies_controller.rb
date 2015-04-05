class EnergiesController < ApplicationController
  def all
    @energies = Energy.order(:id)

    respond_to do |format|
      format.html
      format.csv { send_data @energies.as_csv }
    end
  end
end
