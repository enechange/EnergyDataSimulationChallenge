class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string  :firstname,     null: false
      t.string  :lastname,      null: false
      t.integer :city,          null: false
      t.integer :num_of_people, null: false
      t.boolean :has_child,     null: false
      t.timestamps
    end
  end
end
