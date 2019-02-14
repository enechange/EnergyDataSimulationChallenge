class HouseEnergyUsage < ApplicationRecord
  has_many :energy_productions, foreign_key: 'house'

  def has_child=(params)
    boolean_converter =
      if params == 'Yes'
        true
      elsif params == 'No'
        false
      else
        params
      end

    super(boolean_converter)
  end
end
