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
    
    #都市ごとの世帯平均発電量をjson化
    @energy_average_json = [
      @london_energy_average,
      @cambridge_energy_average,
      @oxford_energy_average
    ].to_json

    #都市ごとの平均日射量
    @london_daylight_average = city_daylight_average(@london_house)
    @cambridge_daylight_average = city_daylight_average(@cambridge_house)
    @oxford_daylight_average = city_daylight_average(@oxford_house)

    #都市ごとの平均日射量をjson化
    @daylight_average_json = [
      @london_daylight_average,
      @cambridge_daylight_average,
      @oxford_daylight_average
    ].to_json

    # 各世帯の人数
    num_of_people = array_num_of_people()

    # 各世帯の一人あたり発電量
    per_person_energy = array_per_person_energy(num_of_people)
    @per_person_energy_json = per_person_energy.to_json
  end

  private

  def search_house_ids(city)
    HouseDatum.where(city: city).pluck(:id)
  end

  def city_energy_average(house_ids)
    energy = house_ids.map {|house_id| (Dataset.where(house: house_id).pluck(:energyproduction).sum)}
    energy.sum / energy.size
  end

  def city_daylight_average(house_ids)
    daylight = house_ids.map {|house_id| (Dataset.where(house: house_id).pluck(:daylight).sum)}
    daylight.sum / daylight.size
  end

  # 各世帯人数の配列
  def array_num_of_people
    HouseDatum.pluck(:num_of_people)
  end

  # 各世帯一人あたり発電量の配列
  def array_per_person_energy(num)
    house_ids = Dataset.pluck(:house).uniq
    house_energy = house_ids.map {|house_id| (Dataset.where(house: house_id).pluck(:energyproduction).sum)}
    house_energy.zip(num).map {|e, n| {x:n, y: (e / n)}}
  end
end
