class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label,             null: false
      t.integer :house_id,          null: false, index: true
      t.integer :year,              null: false
      t.integer :month,             null: false
      t.decimal :temperature,       null: false
      t.decimal :daylight,          null: false
      t.integer :energy_production, null: false
      t.timestamps
    end
  end
end
