class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses, id: :bigint, unsigned: true do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :city, null: false
      t.unsigned_integer :num_of_people, null: false, default: 1
      t.boolean :has_child, null: false, default: false

      t.timestamps

      t.index :city
    end
  end
end
