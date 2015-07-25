class Plan
  include ActiveModel::Model

  attr_accessor :name, :day_time, :night_time, :night_time_range

  def has_night_plan?
    night_time.present? && night_time_range.present?
  end

  def night_time?(hour)
    return false unless has_night_plan?
    return false if hour.to_i < 1
    array_index = hour.to_i - 1
    night_time_range[array_index].present?
  end

  def day_time_unit
    {
      first:  {from: day_time[0][0], to: day_time[0][1], unit: day_time[0][2], cons: 0.0},
      second: {from: day_time[1][0], to: day_time[1][1], unit: day_time[1][2], cons: 0.0},
      third:  {from: day_time[2][0], to: day_time[2][1], unit: day_time[2][2], cons: 0.0},
    }
  end

end
