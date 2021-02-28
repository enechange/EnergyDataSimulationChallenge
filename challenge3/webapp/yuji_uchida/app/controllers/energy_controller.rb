class EnergyController < ApplicationController
  def index
    cities = House.group(:city).select(:city).map{|c| c[:city]}
    joined_data = House.joins(:energy)
    @data = cities.map do |city|
      { name: city, data: joined_data.where(city: city).group(:year, :month).sum(:energy_production) }
    end
  end
end
