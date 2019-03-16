class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities, comment: 'City Data' do |t|
      t.string :name, comment: 'City Name'

      t.timestamps
    end
  end
end
