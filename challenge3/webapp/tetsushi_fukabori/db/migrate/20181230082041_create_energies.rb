class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label, null: false
      t.bigint :house_id, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.float :production, null: false

      t.timestamps
    end
    add_index :energies, :house_id
  end
end
