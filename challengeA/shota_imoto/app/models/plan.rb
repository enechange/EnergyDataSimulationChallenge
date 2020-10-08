class Plan < ApplicationRecord
  has_many :basic_charge
  has_many :usage_charge
  belongs_to :provider
end
