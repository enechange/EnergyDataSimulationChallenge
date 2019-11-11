class AddIndexEnergiesHouseId < ActiveRecord::Migration[5.2]
  def change
    add_index :energies, :house_id
  end
end
