class CreateBasicCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :basic_charges do |t|
      t.integer :current, null: false
      t.integer :charge, null: false
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
