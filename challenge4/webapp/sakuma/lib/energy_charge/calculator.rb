module EnergyCharge

  class Calculator

    def initialize(plan:, consumptions:)
      @plan = plan
      @monthly_cons = consumptions
    end

    def calc
      monthly_day_time_cons = BigDecimal("0.0")
      monthly_night_time_cons = BigDecimal("0.0")
      @monthly_cons.each do |daily_cons|
        aggregator = DailyAggregator.new(plan: @plan, daily_cons: daily_cons)
        day_time_cons, night_time_cons = aggregator.aggregate
        monthly_day_time_cons += day_time_cons
        monthly_night_time_cons += night_time_cons
      end
      result = calc_day_time(monthly_day_time_cons)
      result += calc_night_time(monthly_night_time_cons) if @plan.has_night_plan?

      result
    end

    private

    def calc_day_time(consumption)
      return 0 if consumption.zero?
      cons = BigDecimal(consumption.to_s)
      units = @plan.day_time_unit

      if cons <= units[:first][:to]
        return units[:first][:unit] * cons
      else
        units[:first][:cons] = units[:first][:to]
        current_cons = cons - units[:first][:to]
      end

      if units[:second][:from] < cons && cons <= units[:second][:to]
        return (units[:first][:unit] * units[:first][:cons]) +
          (units[:second][:unit] * current_cons)
      else
        units[:second][:cons] = (units[:second][:to] - units[:second][:from])
        current_cons = cons - units[:second][:to]
      end

      (units[:first][:unit] * units[:first][:cons]) +
        (units[:second][:unit] * units[:second][:cons]) +
        (units[:third][:unit] * current_cons)
    end

    def calc_night_time(consumption)
      BigDecimal(@plan.night_time_unit.to_s) * BigDecimal(consumption.to_s)
    end
  end
end
