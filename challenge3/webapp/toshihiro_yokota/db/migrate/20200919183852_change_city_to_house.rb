class ChangeCityToHouse < ActiveRecord::Migration[6.0]
  def change
    remove_column :houses, :city
    add_column :houses, :city_id, :integer
  end
end
