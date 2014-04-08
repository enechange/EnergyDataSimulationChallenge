class Addindex < ActiveRecord::Migration
  def change
      add_index :houses, :house
      add_index :energylogs, :house_id
  end
end
