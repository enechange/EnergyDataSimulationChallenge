class Api::V1::DashboardController < ApplicationController
  def index
    energies = House.city_energy_production
    energy_production = []
    date = []
    cambridge = []
    london = []
    oxford = []

    energies.each.with_index {|(k, v), i|
      d_num = (i+3) % 3 ##k[2]で取っても良かったかも
      if d_num == 0 #Cambridge
        cambridge << v
        date << "#{k[0]}-#{k[1]}"
      elsif d_num == 1 #London
        london << v
      elsif d_num == 2 #Oxford
        oxford << v
      end
    }
    date.each_with_index{|m, n|
      energy_production << {date: m, cambridge: cambridge[n], london: london[n], oxford: oxford[n]}
    }

    render json: { status: 'SUCCESS', message: 'Loaded chart', data: energy_production }
  end
end