class CreateDatasets < ActiveRecord::Migration[5.2]
  def change
    create_table :datasets do |t|
      t.integer         :Label
      t.integer         :Year
      t.integer         :Month
      t.integer         :Temperature
      t.integer         :Daylight
      t.integer         :EnergyProduction
      t.timestamps      null: true
    end
  end
end
