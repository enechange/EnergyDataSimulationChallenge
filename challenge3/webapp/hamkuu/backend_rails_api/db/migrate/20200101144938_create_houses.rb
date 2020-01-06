class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.references :house_owner, null: false, foreign_key: true
      t.integer :residents_count
      t.boolean :has_children
      t.string :city

      t.timestamps
    end
  end
end
