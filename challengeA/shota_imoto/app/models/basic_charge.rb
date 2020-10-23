class BasicCharge < ApplicationRecord
  belongs_to :plan
  scope :current_order, -> {order(current: "ASC")}
end
