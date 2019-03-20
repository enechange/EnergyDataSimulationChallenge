class AddIdToHouses < ActiveRecord::Migration[5.2]
  def change
    add_column :houses, :original_id, :integer
  end
end
