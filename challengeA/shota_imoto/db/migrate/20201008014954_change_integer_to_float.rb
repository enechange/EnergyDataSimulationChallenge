class ChangeIntegerToFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :basic_charges, :charge, :float
    change_column :usage_charges, :charge, :float
  end
end
