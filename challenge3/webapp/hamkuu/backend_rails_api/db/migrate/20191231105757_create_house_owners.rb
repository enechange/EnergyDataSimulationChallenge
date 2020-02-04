class CreateHouseOwners < ActiveRecord::Migration[6.0]
  def change
    create_table :house_owners do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
