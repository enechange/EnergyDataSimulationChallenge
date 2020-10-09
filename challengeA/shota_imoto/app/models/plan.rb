class Plan < ApplicationRecord
  has_many :basic_charges
  has_many :usage_charges
  belongs_to :provider

  def calculate_usage_charge(power_consumption)
    sum_usage_charge = 0
    self.usage_charges.each do |usage_charge|
      break if power_consumption < usage_charge.lower_power
      sum_usage_charge += usage_charge.calculate_usage_charge_each_of_range(power_consumption)
    end
    return sum_usage_charge
  end
end
