class HomeController < ApplicationController
  def index
    city_name = params['chart'] ? params['chart']['city'] : "all"
    @energies = House.select_city( city_name ).sum_data.transpose
    @selected_type = params['chart'] ? params['chart']['type'] : 0
    @selected_city = params['chart'] ? params['chart']['city'] : "all"
    set_chart(@energies)
  end

  private
  
  def set_chart(data)
    data = data.dup
    if params['chart'] && params['chart']['type'] != '0'
      data[1] = "" if params['chart']['type'] != '1'
      data[2] = "" if params['chart']['type'] != '2'
      data[3] = "" if params['chart']['type'] != '3'
    end

    gon.dataset = {
      "labels": data[0],
      "temperature": data[1],
      "daylight": data[2],
      "production": data[3],
    }
  end
end
