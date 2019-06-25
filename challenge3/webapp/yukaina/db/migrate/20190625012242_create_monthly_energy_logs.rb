class CreateMonthlyEnergyLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :monthly_energy_logs do |t|
      t.references :monthly_label, foreign_key: true
      t.references :house, foreign_key: true
      t.references :family, foreign_key: true
      t.decimal :temperature, precision: 5, scale: 2, null: false
      t.decimal :daylight, precision: 5, scale: 2, null: false
      t.integer :production_volume, null: false

      t.timestamps
    end
    add_index :monthly_energy_logs, [:monthly_label_id, :house_id, :family_id], :name => 'uidx01_monthly_energy_logs', unique: true
  end
end
