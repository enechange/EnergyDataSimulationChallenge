class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.integer :city, limit: 1, null: false
      t.integer :num_of_people
      t.boolean :has_child

      t.timestamps
    end
  end
end
