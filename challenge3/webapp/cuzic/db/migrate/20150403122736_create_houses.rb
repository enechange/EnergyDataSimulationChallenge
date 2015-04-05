class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses, id: false do |t|
      t.integer :id
      t.string :firstname
      t.string :lastname
      t.string :city
      t.integer :num_of_people
      t.boolean :has_child

      t.timestamps null: false
    end

    execute "ALTER TABLE houses ADD PRIMARY KEY (id);"
  end
end
