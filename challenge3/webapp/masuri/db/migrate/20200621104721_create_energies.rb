class CreateEnergies < ActiveRecord::Migration[6.0]
  def change
    create_table :energies do |t|
      t.integer :label
      t.references :house, foreign_key: true, null: false
      t.integer :year
      t.integer :month
      t.decimal :temperature, precision: 3, scale: 1
      t.decimal :daylight, precision: 4, scale: 1
      t.integer :energy_production

      t.timestamps
    end
  end
end
