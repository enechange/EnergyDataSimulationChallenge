class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.string :firstname,                      :null => false, :comment => "家主の名"
      t.string :lastname,                       :null => false, :comment => "家主の姓"
      t.integer :city,                          :null => false, :comment => "都市(enum)"
      t.integer :num_of_people,                 :null => false, :comment => "家庭の人数"
      t.boolean :has_child, :default => false,  :null => false, :comment => "子供の有無"

      t.timestamps
    end

    add_index :houses, :city
    add_index :houses, :num_of_people
    add_index :houses, :has_child
  end
end
