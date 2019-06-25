class CreateHouses < ActiveRecord::Migration[5.2]
  def change
    create_table :houses do |t|
      t.references :city, foreign_key: true
      t.references :family, foreign_key: true

      t.timestamps
    end
  end
end
