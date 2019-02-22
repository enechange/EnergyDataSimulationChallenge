class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.integer :houses, :origin_id, null: false
      t.string :houses, :firstname, null: false
      t.string :houses, :lastname, null: false
      t.string :houses, :city, null: false
      t.integer :houses, :num_of_people, null: false
      t.boolean :houses, :has_child, default: false, null: false

      t.timestamps
    end
  end
end
