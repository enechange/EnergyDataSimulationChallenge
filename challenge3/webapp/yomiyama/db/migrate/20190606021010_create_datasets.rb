class CreateDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :datasets do |t|
      t.integer :label, null:false
      t.integer :house, null:false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null:false
      t.float :daylight, null: false
      t.integer :energyproduction, null: false

      t.timestamps
    end
  end
end
