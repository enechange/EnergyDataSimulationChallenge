class CreateDatasets < ActiveRecord::Migration
  def change
    create_table :datasets do |t|
      t.integer :id2
      t.integer :label
      t.integer :house
      t.integer :year
      t.integer :month
      t.float :templature
      t.float :daylight
      t.integer :energyproduction

      t.timestamps
    end
  end
end
