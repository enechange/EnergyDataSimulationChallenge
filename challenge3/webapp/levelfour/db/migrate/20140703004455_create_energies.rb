class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies do |t|
      t.references :house, index: true
      t.integer :label
      t.datetime :month
      t.float :temperature
      t.float :daylight
      t.integer :energy_production

      t.timestamps
    end
  end
end
