class EnergiesController < ApplicationController
  def index
    city = params[:city] || 'All'
    kind = params[:kind].to_i || 0
    @energies = Energy.city_place(city)
    if city == 'All' && kind != 0
      @monthly_energies = Energy.all_kinds(@energies, kind)
    elsif city == 'All' || kind.zero?
      @monthly_energies = Energy.monthly_average(@energies)
      to_gon(@monthly_energies)
    else
      @monthly_energies = Energy.one_of_cities_for_kind(@energies, kind)
    end
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
