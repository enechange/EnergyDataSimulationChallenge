class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.integer :csv_house_id, null: false
      t.string :firstname
      t.string :lastname
      t.string :city
      t.integer :num_of_people
      t.boolean :has_child

      t.timestamps
    end

    add_index :houses, :csv_house_id, unique: true
  end
end
