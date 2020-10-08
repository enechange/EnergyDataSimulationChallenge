class UsageCharge < ApplicationRecord
  belongs_to :plan
  def calculate_usage_charge_each_of_range(power_consumption)
    if power_consumption > self.upper_power
      self.charge * (self.upper_power - self.lower_power)
    else
      self.charge * (power_consumption - self.lower_power)
    end
  end
end
