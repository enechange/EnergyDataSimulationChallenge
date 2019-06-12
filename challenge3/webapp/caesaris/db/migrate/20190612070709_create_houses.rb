class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :firstname
      t.string :lastname
      t.string :city_text
      t.integer :city_id
      t.integer :num_of_people
      t.boolean :has_child

      t.timestamps
    end
    add_index :houses, :firstname
    add_index :houses, :lastname
    add_index :houses, :city_text
    add_index :houses, :city_id
    add_index :houses, :num_of_people
    add_index :houses, :has_child
  end
end
