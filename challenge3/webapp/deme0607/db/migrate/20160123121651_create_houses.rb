class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :city_id, null: false
      t.integer :num_of_people, null: false
      t.boolean :has_child, null: false
      t.timestamps null: false
    end

    add_foreign_key :houses, :cities
  end
end
