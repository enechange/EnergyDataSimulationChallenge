class ChangeDatatypeHasChildOfHouses < ActiveRecord::Migration[5.0]
  def change
    change_column :houses, :has_child, :boolean, default: false, null: false
  end
end
