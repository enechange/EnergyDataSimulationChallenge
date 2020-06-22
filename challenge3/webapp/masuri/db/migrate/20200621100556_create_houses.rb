class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :city
      t.integer :num_of_people
      t.string :has_child

      t.timestamps
    end
  end
end
