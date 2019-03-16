class CreateMonthlyHouseEnergyProductions < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_house_energy_productions do |t|
      t.integer :label
      t.references :house, foreign_key: true
      t.integer :year
      t.integer :month
      t.float :temperature
      t.float :daylight
      t.integer :energy_production

      t.timestamps
    end
  end
end
