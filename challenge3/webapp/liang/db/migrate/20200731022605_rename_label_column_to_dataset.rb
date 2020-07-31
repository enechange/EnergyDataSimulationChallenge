class RenameLabelColumnToDataset < ActiveRecord::Migration[5.2]
  def change
    rename_column :datasets, :ID, :id
    rename_column :datasets, :Label, :label
    rename_column :datasets, :House, :house
    rename_column :datasets, :Year, :year
    rename_column :datasets, :Month, :month
    rename_column :datasets, :Temperature, :temperature
    rename_column :datasets, :Daylight, :daylight
    rename_column :datasets, :EnergyProduction, :energyProduction
  end
end
