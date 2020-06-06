class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.string :num_of_people
      t.boolean :has_child

      t.timestamps
    end
  end
end
