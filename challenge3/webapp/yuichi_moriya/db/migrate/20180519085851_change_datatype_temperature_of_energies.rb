class ChangeDatatypeTemperatureOfEnergies < ActiveRecord::Migration[5.0]
  def change
    change_column :energies, :temperature, :float, null: false
    change_column :energies, :daylight, :float, null: false
  end
end
