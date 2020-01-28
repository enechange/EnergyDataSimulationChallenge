class EnergiesController < ApplicationController
  def index
    city_selection = params[:city] || 'All'
    @energies = Energy.city_place(city_selection)
    @monthly_energies = Energy.monthly_average(@energies)
    to_gon(@monthly_energies)
    respond_to do |format|
      format.html
      format.json { render json: @monthly_energies }
    end
  end

  private

  def to_gon(data)
    gon.data = {
      labels: data[:labels],
      temperatures: data[:temperatures],
      daylights: data[:daylights],
      energy_productions: data[:energy_productions]
    }
  end
end
