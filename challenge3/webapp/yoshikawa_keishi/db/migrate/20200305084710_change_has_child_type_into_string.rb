class ChangeHasChildTypeIntoString < ActiveRecord::Migration[6.0]
  def change
    change_column :houses, :has_child, :string
  end
end
