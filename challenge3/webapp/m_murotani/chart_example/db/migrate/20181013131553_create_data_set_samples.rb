class CreateDataSetSamples < ActiveRecord::Migration[5.2]
  def change
    create_table :data_set_samples do |t|
      t.integer :label
      t.integer :house
      t.integer :year
      t.integer :month
      t.float :temperature
      t.float :day_light
      t.integer :engery_production
      t.timestamps
    end
    add_index :data_set_samples, :year
    add_index :data_set_samples, :month
  end
end
