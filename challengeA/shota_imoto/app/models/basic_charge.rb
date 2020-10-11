class BasicCharge < ApplicationRecord
  belongs_to :plan
  def self.suitable_for_current(current)
    self.find_by(current: current)
  end
end
