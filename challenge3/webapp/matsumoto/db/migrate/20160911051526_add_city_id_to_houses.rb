class AddCityIdToHouses < ActiveRecord::Migration[5.0]
  def change
    add_reference :houses, :city, foreign_key: true
  end
end
