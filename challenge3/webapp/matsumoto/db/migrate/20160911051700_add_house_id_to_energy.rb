class AddHouseIdToEnergy < ActiveRecord::Migration[5.0]
  def change
    add_reference :energies, :house, foreign_key: true
  end
end
