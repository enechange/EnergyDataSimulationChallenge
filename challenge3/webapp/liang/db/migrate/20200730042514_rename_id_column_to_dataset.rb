class RenameIdColumnToDataset < ActiveRecord::Migration[5.2]
  def change
    rename_column :datasets, :id, :ID
  end
end
