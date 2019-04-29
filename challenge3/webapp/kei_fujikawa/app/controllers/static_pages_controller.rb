class StaticPagesController < ApplicationController
  def home
    #各cityに属するhouseのid配列
    @london_ids = get_city_ids("London")
    @cambridge_ids = get_city_ids("Cambridge")
    @oxford_ids = get_city_ids("Oxford")

    #各cityに属するhouseのenergyproductionの値を格納した配列
    @energy_array_london = get_energy_array(@london_ids)
    @energy_array_cambridge = get_energy_array(@cambridge_ids)
    @energy_array_oxford = get_energy_array(@oxford_ids)

    #各cityの一人当たりのenegyproductionの平均値
    @mean_energy_london = cal_mean_value(@energy_array_london)
    @mean_energy_cambridge = cal_mean_value(@energy_array_cambridge)
    @mean_energy_oxford = cal_mean_value(@energy_array_oxford)

    #各家庭の一人当たりのenergyproductionとdaylightの値を取得
    @all_ids = HouseDatum.pluck(:id)
    @energy_array_all = get_energy_array(@all_ids)
    @daylight_array_all = get_daylight_array(@all_ids)

    #グラフ描画用にデータを加工
    @energydata_cities = [@mean_energy_london, @mean_energy_cambridge, @mean_energy_oxford]
    @energydata_cities_json = @energydata_cities.to_json.html_safe
    @energy_data_all_json = @energy_array_all.to_json.html_safe
    @daylight_data_all_json = @daylight_array_all.to_json.html_safe
  end

  private
  # cityの名前を与えると、そのcityに属するhouseのidを配列で返す
  def get_city_ids(city_name)
    return HouseDatum.where('city = ?', city_name).pluck(:id)
  end

  # あるidに該当する各家庭の一人当たりの全期間のenegyproductionの平均値を取得し、配列に格納する
  def get_energy_array(ids)
    energy_array = ids.map{|id| (Dataset.where('house = ?', id).average(:energyproduction)/HouseDatum.find(id).num_of_people).round(0)}
  end

  # あるidに該当する各家庭の一人当たりの全期間のdaylightの平均値を取得し、配列に格納する
  def get_daylight_array(ids)
    daylight_array = ids.map{|id| (Dataset.where('house = ?', id).average(:daylight)).round(0)}
  end

  #ある配列の平均値を算出
  def cal_mean_value(array)
    return (array.inject(:+)/array.length).round(0)
  end
end
