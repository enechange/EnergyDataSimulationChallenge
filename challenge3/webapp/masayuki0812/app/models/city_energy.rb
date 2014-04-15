class CityEnergy < ActiveRecord::Base
  belongs_to :city

  def self.sum_by_city_id(id=nil)
    sum = group('city_id').sum('energy_production')
    id ? sum[id.to_i] : sum
  end

end
