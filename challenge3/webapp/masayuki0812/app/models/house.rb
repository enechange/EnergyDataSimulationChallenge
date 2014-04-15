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

end
