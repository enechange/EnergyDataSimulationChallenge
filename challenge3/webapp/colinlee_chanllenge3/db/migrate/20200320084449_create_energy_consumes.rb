class CreateEnergyConsumes < ActiveRecord::Migration[6.0]
  def change
    create_table :energy_consumes do |t|
      t.integer :uuid, null: false, unique: true
      t.integer :label
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, default: 0, null: false
      t.float :daylight, default: 0, null: false
      t.integer :energy_production, default: 0, null: false
      t.integer :house_id

      t.timestamps
    end
    add_index :energy_consumes, :uuid, unique: true
    add_index :energy_consumes, :house_id
  end
end
