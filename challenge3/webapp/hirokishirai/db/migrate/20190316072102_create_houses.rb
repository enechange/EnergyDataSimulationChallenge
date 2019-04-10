# frozen_string_literal: true

class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses, comment: 'House Data' do |t|
      t.string :firstname, comment: 'Resident First Name'
      t.string :lastname, comment: 'Resident Last Name'
      t.references :city, foreign_key: true
      t.integer :num_of_people, comment: 'Number of Residents'
      t.boolean :has_child, comment: 'Child flag'

      t.timestamps
    end
  end
end
