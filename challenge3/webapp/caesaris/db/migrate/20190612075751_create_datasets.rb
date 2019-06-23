class CreateDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :datasets do |t|
      t.integer :label
      t.integer :house_id
      t.integer :year
      t.integer :month
      t.float :temperature
      t.float :daylight
      t.integer :energy_production

      t.timestamps
    end
    add_index :datasets, :label
    add_index :datasets, :house_id
    add_index :datasets, :year
    add_index :datasets, :month
    add_index :datasets, :temperature
    add_index :datasets, :daylight
    add_index :datasets, :energy_production
  end
end
