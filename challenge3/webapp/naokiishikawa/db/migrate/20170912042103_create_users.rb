class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.integer    "user_id",       null: false, index: true
      t.string     "first_name",    null: false
      t.string     "last_name",     null: false
      t.string     "city",          null: false
      t.integer    "num_of_people", null: false
      t.string     "has_child_cd",  null: false
      t.timestamps                  null: false
    end
  end
end
