class House < ActiveRecord::Base
  has_many :energies
  belongs_to :city

  def self.energies(id)
    house = find(id)
    data = house ? house.energies.map{|e| ["#{e.year}-#{e.month}", e.energy_production]} : []
    {
      data: [["Date", "Energy Production"]] + data
    }
  end

  def self.count_by_city_id(id=nil)
    count = House.select(:city_id).group('city_id').count()
    id ? count[id.to_i] : count
  end

end
