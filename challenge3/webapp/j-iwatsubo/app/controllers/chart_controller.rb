class ChartController < ApplicationController
  def index
    # data
    @house = House.all
    @energy_production = EnergyProduction.all

    # data for chart(top10 list)
    @limit = 10
    @house_max_list = get_energy_prod_max(@limit)
    @house_ave_list = get_energy_prod_ave(@limit)

    # data for chart(bar data)
    gon.house_max_bardata = get_bar_data_list(@house_max_list)
    gon.house_ave_bardata = get_bar_data_list(@house_ave_list)
  end

  private
  def get_energy_prod_max(limit)
    house_list = []

    House.all.each do |h|
      max = 0
      max_ep_record = nil

      h.energy_productions.each do |e|
        value = e.energy_production
        if value > max
          max = value.round(3)
          max_ep_record = e
        end
      end

      if max_ep_record and max > 0
        house_list.append([h, max_ep_record, max])
      end
    end

    # sort by average(max)
    house_list.sort_by!{|item| [-item[2], item[0][:id]]  }

    return house_list[0..(limit-1)]
  end

  def get_energy_prod_ave(limit)
    house_list = []

    # get energy production average
    House.all.each do |h|
      sum = 0
      h.energy_productions.each do |e|
        sum += e.energy_production
      end
      if h.energy_productions.length > 0
        value_ave = sum / h.energy_productions.length
        value_ave = value_ave.round(3)
        house_list.append([h, value_ave])
      end
    end

    # sort by average(desc)
    house_list.sort_by!{|item| [-item[1], item[0][:id]] }

    return house_list[0..(limit-1)]
  end

  def get_bar_data_list(house_list)
    bar_list = []
    house_list.each do |h|
      bar_list << h[-1]
    end
    return bar_list
  end
 end
