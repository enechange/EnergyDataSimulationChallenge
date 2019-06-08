class ChartsController < ApplicationController
  def index
    #都市ごとのhouse id の配列作成
    @london_house = search_house_ids("London")
    @cambridge_house = search_house_ids("Cambridge")
    @oxford_house = search_house_ids("Oxford")
    
    #都市ごとの世帯平均発電量
    @london_energy_average = city_energy_average(@london_house)
    @cambridge_energy_average = city_energy_average(@cambridge_house)
    @oxford_energy_average = city_energy_average(@oxford_house)
    
    #各都市の世帯平均発電量をjson化
    @energy_average_json = [
      @london_energy_average,
      @cambridge_energy_average,
      @oxford_energy_average
    ].to_json
  end

  private

  def search_house_ids(city)
    HouseDatum.where(city: city).pluck(:id)
  end

  def city_energy_average(house_ids)
    energy = house_ids.map {|house_id| (Dataset.where(house: house_id).pluck(:energyproduction).sum)}
    energy.sum / energy.size
  end
end
