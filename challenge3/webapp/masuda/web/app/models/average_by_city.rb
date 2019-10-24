class AverageByCity < ApplicationRecord
  def self.getTemperature
    ActiveRecord::Base.connection.select_all("SELECT city,avg(temperature),year,month FROM energy_productions LEFT OUTER JOIN houses on energy_productions.house_id=houses.id GROUP BY city, year ,month ORDER BY year , month;").to_hash
  end

  def self.getDaylight
    ActiveRecord::Base.connection.select_all("SELECT city,avg(daylight),year,month FROM energy_productions LEFT OUTER JOIN houses on energy_productions.house_id=houses.id GROUP BY city, year ,month ORDER BY year , month;").to_hash
  end

  def self.getEnergyProduction
    ActiveRecord::Base.connection.select_all("SELECT city,avg(energy_production),year,month FROM energy_productions LEFT OUTER JOIN houses on energy_productions.house_id=houses.id GROUP BY city, year ,month ORDER BY year , month;").to_hash
  end
end
