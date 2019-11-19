class CreateCityEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :city_energies do |t|
      t.integer :city_id
      t.integer :year
      t.integer :month
      t.integer :energy_production

      t.timestamps
    end
  end
end
