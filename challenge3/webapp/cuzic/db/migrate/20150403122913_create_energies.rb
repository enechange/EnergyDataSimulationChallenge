class CreateEnergies < ActiveRecord::Migration
  def change
    create_table :energies, id: false do |t|
      t.integer :id
      t.integer :label
      t.integer :house_id
      t.integer :year
      t.integer :month
      t.decimal :temperature
      t.decimal :daylight
      t.integer :energy_production

      t.timestamps null: false
    end

    execute "ALTER TABLE energies ADD PRIMARY KEY (id);"
  end
end
