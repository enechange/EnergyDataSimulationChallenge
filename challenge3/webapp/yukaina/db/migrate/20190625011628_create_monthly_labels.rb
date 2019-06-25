class CreateMonthlyLabels < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_labels do |t|
      t.integer :year, null: false
      t.integer :month, null: false

      t.timestamps
    end
    add_index :monthly_labels, [:year, :month], :name => 'uidx01_monthly_labels', unique: true
  end
end
