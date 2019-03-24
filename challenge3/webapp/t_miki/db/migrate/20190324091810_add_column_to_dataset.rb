class AddColumnToDataset < ActiveRecord::Migration[5.2]
  def change
    add_reference :datasets, :house, foreign_key: true, after: :Label
  end
end
