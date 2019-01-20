class CreateDataSets < ActiveRecord::Migration[5.2]
  def change
    create_table :data_sets, id: :bigint, unsigned: true do |t|
      t.unsigned_integer :label, null: false
      t.unsigned_bigint :house_id, null: false
      t.unsigned_integer :year, null: false, limit: 2
      t.unsigned_integer :month, null: false, limit: 1
      t.float :temperature, null: false, default: 0.0
      t.float :daylight, null: false, default: 0.0
      t.unsigned_integer :energy_production, null: false

      t.timestamps

      t.index :year
      t.index :month
      t.index :label
    end
  end
end
