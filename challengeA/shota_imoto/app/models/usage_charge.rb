class UsageCharge < ApplicationRecord
  require 'bigdecimal'

  belongs_to :plan
  def calculate_usage_charge_each_of_range(power_consumption)
    if power_consumption > self.upper_power
      BigDecimal(self.charge_s) * (self.upper_power - self.lower_power)
    else
      BigDecimal(self.charge_s) * (power_consumption - self.lower_power)
    end
  end

  def charge_s
    self.charge.to_s
  end
end
