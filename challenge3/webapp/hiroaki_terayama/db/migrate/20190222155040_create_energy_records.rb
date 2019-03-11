class CreateEnergyRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_records do |t|
      t.references :house, foreign_key: true
      t.integer :origin_id, null: false
      t.integer :label, null: false
      t.integer :house_origin_id, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.integer :energy_production, null: false

      t.timestamps
    end
  end
end
