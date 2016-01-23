class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies do |t|
      t.integer :house_id, null: false
      t.integer :label, null: false
      t.float   :temperature, null: false
      t.float   :daylight, null: false
      t.integer :energy_production, null: false
      t.date    :recorded_at, null: false
    end

    add_index :energies, [:house_id, :label], unique: true
    add_index :energies, :recorded_at

    add_foreign_key :energies, :houses
  end
end
