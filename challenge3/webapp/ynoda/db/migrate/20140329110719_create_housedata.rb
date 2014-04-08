class CreateHousedata < ActiveRecord::Migration
  def change
    create_table :housedata do |t|
      t.integer :house
      t.string :firstname
      t.string :lastname
      t.string :city
      t.integer :n_of_people
      t.string :has_child

      t.timestamps
    end
  end
end
