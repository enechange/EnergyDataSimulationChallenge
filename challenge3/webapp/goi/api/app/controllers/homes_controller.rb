class HomesController < ApplicationController
  def index
    energies = House.city_energy_production
    year = []
    month = []
    name = []
    energy_production = []
    energies.each{|k,v|
      year << k[0]
      month << k[1]
      name << k[2]
      energy_production << v
    }

    energy_production_max = energy_production.max.ceil
    energy_production_min = energy_production.min.floor # 多分いらない
    energies = {
                  year: year,
                  month: month,
                  name: name,
                  energy_production: energy_production,
                  energy_production_max: energy_production_max,
                  energy_production_min: energy_production_min
                }

    render json: { status: 'SUCCESS', message: 'Loaded chart', data: energies } 
  end
end
