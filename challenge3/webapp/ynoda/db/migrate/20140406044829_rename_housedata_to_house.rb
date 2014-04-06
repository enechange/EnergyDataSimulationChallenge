class RenameHousedataToHouse < ActiveRecord::Migration
  def change
      rename_table :housedata, :houses
  end
end
