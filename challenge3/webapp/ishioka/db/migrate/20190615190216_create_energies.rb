class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label, null: false
      t.references :house, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.decimal :temperature, precision: 4, scale: 1
      t.decimal :daylight, precision: 5, scale: 1, null: false
      t.integer :energy_production, null: false
      t.timestamps
    end
  end
end
