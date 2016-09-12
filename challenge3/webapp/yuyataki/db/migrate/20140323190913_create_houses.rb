class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :firstname
      t.string :lastname
      t.string :city
      t.integer :num_of_people
      t.boolean :has_child, default: false, null: false

      t.timestamps
    end
  end
end
