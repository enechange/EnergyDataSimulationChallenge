class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string     "first_name",    null: false
      t.string     "last_name",     null: false
      t.string     "city",          null: false
      t.integer    "num_of_people", null: false
      t.boolean    "has_child",     null: false
      t.timestamps                  null: false
    end
  end
end
