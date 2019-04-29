class CreateHouseData < ActiveRecord::Migration[5.2]
  def change
    create_table :house_data do |t|
      t.string :firstname, null: false
      t.string :lastname, null: false
      t.string :city, null: false
      t.integer :num_of_people, default: 1, null: false
      t.boolean :has_child, default: false, null: false

      t.timestamps
    end
  end
end
