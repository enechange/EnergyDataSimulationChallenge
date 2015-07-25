class EnergyCharge::DailyAggregator

  def initialize(plan:, daily_cons:)
    @plan = plan
    @daily_cons = daily_cons
  end

  def aggregate
    day_time_cons = BigDecimal("0.0")
    night_time_cons = BigDecimal("0.0")
    @daily_cons.each.with_index(1) do |hour_cons, hour|
      if @plan.night_time?(hour)
        night_time_cons += BigDecimal(hour_cons.to_s)
      else
        day_time_cons += BigDecimal(hour_cons.to_s)
      end
    end

    [day_time_cons, night_time_cons]
  end
end
