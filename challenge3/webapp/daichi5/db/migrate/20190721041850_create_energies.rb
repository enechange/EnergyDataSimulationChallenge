# frozen_string_literal: true

class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label, null: false
      t.integer :year, null: false
      t.integer :month, null: false
      t.float :temperature, null: false
      t.float :daylight, null: false
      t.integer :energyproduction, null: false

      t.references :house, foreign_key: true

      t.timestamps
    end
  end
end
