class ChartController < ApplicationController
  def index
    gon.year_month_g1 = []
    label_list = []
    EnergyData.select(:label).distinct.each do |l|
      label_list << l.label
    end
    label_list = label_list.sort
    gon.year_month_g1 = convert_to_year_month(label_list)

    gon.energy_production_g1 = {}
    city_list = []
    House.select(:city).distinct.each do |c|
      city_list << c.city
    end
    city_list.each do |city|
      energy_production = []
      label_list.each do |label|
        ep_list = []
        EnergyData.includes(:house).where(houses: { city: city }, label: label).each do |e|
          ep_list << e.energy_production
        end
        ep_average = average(ep_list)
        energy_production << ep_average
      end
      gon.energy_production_g1[city] = energy_production
    end

    ep = EnergyData.pluck(:energy_production).to_vector
    t = EnergyData.pluck(:temperature).to_vector
    d = EnergyData.pluck(:daylight).to_vector
    pearson1 = Statsample::Bivariate::Pearson.new(ep, t)
    pearson2 = Statsample::Bivariate::Pearson.new(ep, d)
    @r1 = pearson1.r.round(4)
    @r2 = pearson2.r.round(4)

    gon.data_g2 = []
    EnergyData.find_each do |e|
      gon.data_g2 << {x: e.daylight, y: e.energy_production}
    end
  end

  def convert_to_year_month(label_list)
    year = nil
    months = []
    label_list.each do |label|
      e = EnergyData.find_by(label: label)
      if year.nil? || e.year != year
        months << "#{e.year}/#{e.month}"
      else
        months << "#{e.month}"
      end
      year = e.year
    end
    return months
  end

  def average(array)
    array.inject(0.to_f) { |s, n| s += n } / array.size
  end
end
