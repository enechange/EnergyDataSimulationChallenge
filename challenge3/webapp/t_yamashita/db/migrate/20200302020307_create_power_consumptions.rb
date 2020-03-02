class CreatePowerConsumptions < ActiveRecord::Migration[5.2]
  def change
    create_table :power_consumptions do |t|
      t.integer :user_id, foreign_key: true, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.integer :power_consumption, null: false
      
      t.timestamps
    end
  end
end
