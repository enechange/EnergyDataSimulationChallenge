class CreateFamilies < ActiveRecord::Migration[5.2]
  def change
    create_table :families do |t|
      t.text :first_name, null: false
      t.text :last_name, null: false
      t.integer :num_of_people, null: false
      t.boolean :has_child, null: false, default:false

      t.timestamps
    end
  end
end
