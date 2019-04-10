# frozen_string_literal: true

class CreateMonthlyHouseEnergyProductions < ActiveRecord::Migration[6.0]
  def change
    create_table :monthly_house_energy_productions, comment: 'Monthly House Energy Production Data' do |t|
      # REVIEW: labelはidと同じ値だが、違う可能性もあるので要確認
      t.integer :label, comment: 'Label'
      t.references :house, foreign_key: true
      t.integer :year, comment: 'Production Year'
      t.integer :month, comment: 'Production Month'
      # REVIEW: 月の平均？　最大？　最小？ 中央値？
      t.float :temperature, comment: 'Temperature'
      # REVIEW: 月の平均？　最大？　最小？ 中央値？
      t.float :daylight, comment: 'Label'
      # REVIEW: 月の平均？　最大？　最小？ 中央値？
      t.integer :energy_production, comment: 'Label'

      t.timestamps
    end
  end
end
