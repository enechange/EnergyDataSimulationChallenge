class CreateEnergyProductions < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_productions do |t|
      t.integer :label
      t.integer :house, foreign_key: true, index: true
      t.integer :year
      t.integer :month
      t.float   :temperature
      t.float   :daylight
      t.integer :energy_production
      t.timestamps
    end
  end
end
