class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies do |t|
      t.integer :label
      t.integer :house
      t.integer :year
      t.integer :month
      t.float :temperature
      t.float :daylight
      t.integer :energy_production

      t.timestamps null: false
    end
  end
end
