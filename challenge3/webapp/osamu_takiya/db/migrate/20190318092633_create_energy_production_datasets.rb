class CreateEnergyProductionDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_production_datasets do |t|
      t.integer :label, null: false
      t.references :house_dataset, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.decimal :temperature, precision: 10, scale: 1, null: false
      t.decimal :daylight, precision: 10, scale: 1, null: false
      t.integer :energy_production, null: false

      t.timestamps
    end
  end
end
