module Plan
  class NightPlan < PlanBase
    def initialize(plan)
      @nighttime_total_usage = 0.0
      @daytime_total_usage = 0.0
      @night_time_range = plan["Night time range"]

      parse_daytime_price_ranges(plan["Day time"])
      parse_nighttime_price(plan["Night time"])
    end

    def calc(usage)
      calc_total_usage(usage)

      @price = calc_price(@daytime_total_usage) + calc_nighttime_price
    end

    private

      def parse_nighttime_price(price)
        @night_time_price = price.first.third
      end

      def calc_total_usage(usage)
        usage.each do |usage_in_a_day|
          usage_in_a_day.zip(@night_time_range).each do |u, is_nighttime|
            if is_nighttime
              @nighttime_total_usage += u
            else
              @daytime_total_usage   += u
            end
          end
        end
      end

      def calc_nighttime_price
        @night_time_price * @nighttime_total_usage
      end
  end
end
