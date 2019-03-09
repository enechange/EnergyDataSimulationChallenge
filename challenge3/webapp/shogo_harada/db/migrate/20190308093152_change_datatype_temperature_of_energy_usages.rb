class ChangeDatatypeTemperatureOfEnergyUsages < ActiveRecord::Migration[5.2]
  def change
    change_column :energy_usages, :temperature, :float
  end
end
