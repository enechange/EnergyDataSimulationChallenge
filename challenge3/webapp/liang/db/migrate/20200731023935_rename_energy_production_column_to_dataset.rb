class RenameEnergyProductionColumnToDataset < ActiveRecord::Migration[5.2]
  def change
    rename_column :datasets, :energyProduction, :energyproduction
  end
end
