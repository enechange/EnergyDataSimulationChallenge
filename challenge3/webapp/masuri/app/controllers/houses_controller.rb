class HousesController < ApplicationController
  before_action :set_house, only: :show

  def index
    @houses = House.all
    cities = @houses.pluck(:city).uniq
    @data = []
    cities.each do |city|
      data_hash = {}
      data_hash[:name] = city
      data_hash[:data] = House.where(city: city).joins(:energies).group(:year, :month).sum(:energy_production)
      @data.push(data_hash)
    end
  end

  def show
    @energies = @house.energies.group(:year, :month)
  end

  private

  def set_house
    @house = House.find(params[:id])
  end
end
