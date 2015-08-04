class Plan
  include ActiveModel::Model

  attr_accessor :name, :day_time, :night_time, :night_time_range

  def has_night_plan?
    night_time.present? && night_time_range.present?
  end

  def night_time?(hour)
    return false unless has_night_plan?
    return false unless hour.is_a?(Integer)
    return false unless (1..24).include?(hour)
    array_index = (hour == 24) ? 0 : hour
    night_time_range[array_index]
  end

  def day_time_unit
    {
      first:  {from: day_time[0][0], to: day_time[0][1], unit: BigDecimal(day_time[0][2].to_s), cons: 0.0},
      second: {from: day_time[1][0], to: day_time[1][1], unit: BigDecimal(day_time[1][2].to_s), cons: 0.0},
      third:  {from: day_time[2][0], to: day_time[2][1], unit: BigDecimal(day_time[2][2].to_s), cons: 0.0},
    }
  end

  def night_time_unit
    return 0 unless has_night_plan?
    night_time[2]
  end

end
