class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.decimal :temperature, null: false, precision: 6, scale: 2
      t.decimal :daylight, null: false, precision: 6, scale: 2
      t.integer :energy_production, null: false

      t.timestamps
    end
  end
end