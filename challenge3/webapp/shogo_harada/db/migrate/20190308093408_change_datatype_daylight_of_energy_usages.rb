class ChangeDatatypeDaylightOfEnergyUsages < ActiveRecord::Migration[5.2]
  def change
    change_column :energy_usages, :daylight, :float
  end
end
