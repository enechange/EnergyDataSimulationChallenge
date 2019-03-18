class CreateEnergyProductionDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_production_datasets do |t|
      t.integer :label
      t.integer :house
      t.integer :year
      t.integer :month
      t.decimal :temperature, precision: 10, scale: 1
      t.decimal :daylight, precision: 10, scale: 1
      t.integer :energy_production

      t.timestamps
    end
  end
end
