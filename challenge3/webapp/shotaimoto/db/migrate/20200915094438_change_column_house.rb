class ChangeColumnHouse < ActiveRecord::Migration[5.2]
  def change
    remove_column :houses, :city
    add_column :houses, :city_id, :integer, foreign_key: true
  end
end
