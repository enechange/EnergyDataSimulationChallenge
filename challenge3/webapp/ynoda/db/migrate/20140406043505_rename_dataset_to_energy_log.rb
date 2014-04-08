class RenameDatasetToEnergyLog < ActiveRecord::Migration
  def change
      rename_table :datasets, :energylogs
  end
end
