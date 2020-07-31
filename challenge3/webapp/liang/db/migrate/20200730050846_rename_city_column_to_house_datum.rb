class RenameCityColumnToHouseDatum < ActiveRecord::Migration[5.2]
  def change
    rename_column :house_data, :ID, :id
    rename_column :house_data, :Firstname, :firstname
    rename_column :house_data, :Lastname, :lastname
    rename_column :house_data, :City, :city
  end
end
