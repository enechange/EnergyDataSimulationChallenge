class CreateHouseData < ActiveRecord::Migration[5.2]
  def change
    create_table :house_data do |t|
      t.string :Firstname
      t.string :Lastname
      t.string :City
      t.integer :num_of_people
      t.boolean :has_child

      t.timestamps
    end
  end
end
