class RenameIdColumnToHouseDatum < ActiveRecord::Migration[5.2]
  def change
    rename_column :house_data, :id, :ID
  end
end
