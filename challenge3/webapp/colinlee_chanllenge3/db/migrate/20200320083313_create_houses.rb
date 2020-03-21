class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :first_name
      t.string :last_name
      t.string :city
      t.integer :living_count, default: 0, null: false
      t.boolean :has_child, default: false, null: false

      t.timestamps
    end
  end
end
