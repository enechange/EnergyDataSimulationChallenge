class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label
      t.integer :house_id
      t.integer :temperature
      t.float :daylight
      t.integer :energy_production
      t.string :year_month

      t.timestamps
    end
  end
end
