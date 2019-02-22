class CreateEnergyRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_records do |t|
      t.references :house, foreign_key: true
      t.integer :energy_records, :origin_id, null: false
      t.integer :energy_records, :label, null: false
      t.integer :energy_records, :house, null: false
      t.integer :energy_records, :year, null: false
      t.integer :energy_records, :month, null: false
      t.float :energy_records, :temperature, null: false
      t.float :energy_records, :daylight, null: false
      t.integer :energy_records, :energy_production, null: false

      t.timestamps
    end
  end
end
