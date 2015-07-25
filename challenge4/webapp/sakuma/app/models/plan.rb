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

end
