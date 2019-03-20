class AddReferencesToEnergies < ActiveRecord::Migration[5.2]
  def change
    add_reference :energies, :house, foreign_key: true
  end
end
