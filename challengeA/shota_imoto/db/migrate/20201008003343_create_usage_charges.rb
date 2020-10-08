class CreateUsageCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :usage_charges do |t|
      t.integer :lower_power, null: false
      t.integer :upper_power, null: false
      t.integer :charge, null: false
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
