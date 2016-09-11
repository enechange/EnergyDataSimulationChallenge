class CreateEnergies < ActiveRecord::Migration[5.0]
  def change
    create_table :energies do |t|
      t.integer :label, null: false
      t.date :record_at, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.integer :energy_production, null: false
      t.timestamps
    end
  end
end
