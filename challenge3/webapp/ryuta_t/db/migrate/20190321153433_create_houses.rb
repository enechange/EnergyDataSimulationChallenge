class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :firstname
      t.string :lastname
      t.string :city
      t.integer :num_of_people
      t.string :has_child

      t.timestamps
    end
  end
end
