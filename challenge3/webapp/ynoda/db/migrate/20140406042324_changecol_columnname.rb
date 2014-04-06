class ChangecolColumnname < ActiveRecord::Migration
  def change
      rename_column :datasets, :house, :house_id
  end
end
