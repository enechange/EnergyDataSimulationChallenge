module Plan
  class NightPlan < PlanBase
    def initialize(plan)
      parse_daytime_price_ranges(plan["Day time"])
      parse_nighttime_price(plan["Night time"])

      @night_time_range = plan["Night time range"]
      result = 0
    end

    def calc(usage)
      puts "night plan! #{usage}"
    end

    private

      def parse_nighttime_price(price)
        @night_time_price = price.first.third
      end
  end
end
