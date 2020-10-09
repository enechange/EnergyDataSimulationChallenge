module PlansHelper
  def show_power_range(usage_charge)
    text = ""
    text += "#{usage_charge.lower_power} 〜"
    if usage_charge.upper_power <= 99999
      text += usage_charge.upper_power.to_s
    else
      text
    end
  end
end
