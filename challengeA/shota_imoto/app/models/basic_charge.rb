class BasicCharge < ApplicationRecord
  belongs_to :plan
  scope :suitable_for_current, -> (current){find_by(current: current)}

end
