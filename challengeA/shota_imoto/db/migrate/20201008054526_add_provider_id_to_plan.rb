class AddProviderIdToPlan < ActiveRecord::Migration[5.2]
  def change
    add_reference :plans, :provider, foreign_key: true
  end
end
