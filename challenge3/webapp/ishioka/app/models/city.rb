# == Schema Information
#
# Table name: cities
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class City < ApplicationRecord
  has_many :houses

  # 全ての都市の都市別のエネルギー生産量平均値を算出
  def self.average_energies_in_all_city
    average_energies = []
    City.all.each do |city|
      avg = Energy.average_city_energy(city.id)
      average_energies << { name: city.name, data: avg }
    end
    return average_energies
  end
end
