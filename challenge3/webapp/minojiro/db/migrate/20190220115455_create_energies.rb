class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.references :house, foreign_key: true
      t.integer :csv_energy_id, null: false
      t.integer :label
      t.integer :year
      t.integer :month
      t.decimal :temperature
      t.decimal :daylight
      t.integer :energy_production

      t.timestamps
    end

    add_index :energies, :csv_energy_id, unique: true
  end
end
