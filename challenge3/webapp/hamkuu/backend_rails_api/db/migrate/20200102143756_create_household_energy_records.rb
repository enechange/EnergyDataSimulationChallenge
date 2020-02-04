class CreateHouseholdEnergyRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :household_energy_records do |t|
      t.references :house, null: false, foreign_key: true
      t.date :record_date
      t.decimal :temperature, precision: 4, scale: 1
      t.decimal :daylight, precision: 5, scale: 1
      t.decimal :energy_production, precision: 5, scale: 0

      t.timestamps
    end
  end
end
