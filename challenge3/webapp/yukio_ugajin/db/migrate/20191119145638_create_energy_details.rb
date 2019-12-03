class CreateEnergyDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :energy_details do |t|
      t.integer    :label,             null: false
      t.references :house,             null: false, foreign_key: true
      t.integer    :year,              null: false
      t.integer    :month,             null: false
      t.float      :temperature,       null: false
      t.float      :daylight,          null: false
      t.integer    :energy_production, null: false
      t.timestamps
    end
  end
end
