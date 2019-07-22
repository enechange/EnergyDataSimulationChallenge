# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :city, null: false
      t.integer :num_of_people, null: false
      t.string :has_child, null: false

      t.timestamps
    end
  end
end
