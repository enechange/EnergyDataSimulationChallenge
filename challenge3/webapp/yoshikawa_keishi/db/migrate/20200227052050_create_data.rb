class CreateData < ActiveRecord::Migration[6.0]
  def change
    create_table :data do |t|
      t.integer :csv_id, null: false
      t.integer :label
      t.references :house, foreign_key: true
      t.integer :year
      t.integer :month
      t.decimal :temperature, precision: 3, scale: 1
      t.decimal :daylight
      t.integer :energy_production
      t.timestamps
    end
  end
end
