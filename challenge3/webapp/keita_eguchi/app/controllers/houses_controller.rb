class HousesController < ApplicationController
  def index
    @housees = House.all
    @house = House.find(params[:house] || 1)
    @same_condition_houses = House.same_condition(@house)
    kind = params[:kind].to_i || 0

    if kind != 0
      @energies = Energy.kind_select(@house, kind)
      @same_condition_energies = @same_condition_houses.map(&:energies).flatten!
      @monthly_energies = Energy.monthly_average(@same_condition_energies)
    else
      @monthly_energies= Energy.monthly_average(@house.energies)
    end
    @data = {
      labels: @monthly_energies[:labels],
      city: @house[:city],
      num_of_people: @house[:num_of_people],
      has_child: @house [:has_child],
      same_condition_count: @same_condition_houses.length,
      house_energy_kind: @energies,
      same_condition_temperatures: @monthly_energies[:temperatures],
      same_condition_daylights: @monthly_energies[:daylights],
      same_condition_energy_productions: @monthly_energies[:energy_productions]
    }
    to_gon(@data)
    respond_to do |format|
      format.html
      format.json { render json: @data }
    end
  end

  def to_gon(data)
    gon.data = {
      labels: data[:labels],
      house_energy_kind: data[:house_energy_kind],
      same_condition_temperatures: data[:same_condition_temperatures],
      same_condition_daylights: data[:same_condition_daylights],
      same_condition_energy_productions: data[:same_condition_energy_productions]

    }
  end
end
