module Plan
  class BasicPlan < PlanBase
    def initialize(plan)
      parse_daytime_price_ranges(plan["Day time"])
    end

    def calc(usage)
      total_usage = calc_total_usage(usage)
      puts "total_usage = #{total_usage}"

      @result = calc_price(total_usage)
    end

    private

      def calc_total_usage(usage)
        usage.inject(0) do |sum, usage_in_a_day|
          sum += usage_in_a_day.inject(:+)
        end
      end
  end
end
