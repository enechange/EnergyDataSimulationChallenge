class City < ActiveRecord::Base
  has_many :houses
  has_many :city_energies

  def self.energies(id)
    city = find(id)
    data = city ? city.city_energies.map{|e| ["#{e.year}-#{e.month}", e.energy_production]} : []
    {
      data: [["Date", "Energy Production"]] + data
    }
  end

end
