class CityEnergy
  include ActiveModel::Model
  attr_accessor :city_id, :gotten_at, :energy_production

  def city
    @city ||= City.find(city_id)
  end
end
