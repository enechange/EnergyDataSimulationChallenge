class CreateEnergyUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :energy_usages do |t|
      t.integer :label, null: false
      t.references :house, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :temperature, null: false
      t.integer :daylight, null: false
      t.integer :energyproduction, null: false

      t.timestamps
    end
  end
end
