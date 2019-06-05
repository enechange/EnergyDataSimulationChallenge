class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string        :Firstname
      t.string        :Lastname
      t.string        :City
      t.integer       :num_of_people
      t.string        :has_child
      t.timestamps    null: true
    end
  end
end
