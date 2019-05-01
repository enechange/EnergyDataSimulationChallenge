class CreateEnergies < ActiveRecord::Migration[5.2]
  def change
    create_table :energies do |t|
      t.integer :label,             :null => false, comment: "年月のラベル"
      t.belongs_to :house,          :index => true, comment: "House.id"
      t.integer :year,              :null => false, comment: "計測年"
      t.integer :month,             :null => false, comment: "計測月"
      t.integer :year_month,        :null => false, comment: "計測年月(yyyymm)"
      t.decimal :temperature,       :null => false, comment: "気温"
      t.decimal :daylight,          :null => false, comment: "日光"
      t.integer :energy_production, :null => false, comment: "エネルギー生産量"

      t.timestamps
    end

    add_index :energies, :year_month
    add_index :energies, :temperature
    add_index :energies, :daylight
  end
end
