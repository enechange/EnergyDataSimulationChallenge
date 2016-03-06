module Plan
  class BasicPlan < PlanBase
    def initialize(plan)
      parse_daytime_price_ranges(plan["Day time"])
    end

    def calc(usage)
      total_usage = calc_total_usage(usage)
      puts "total_usage = #{total_usage}"

      @result = begin
        case total_usage
        when @low_range
          puts "low!"
          @low_price * total_usage
        when @middle_range
          puts "middle!"
          base_price = @low_price * @middle_range.min
          remaining_price = @middle_price * (total_usage - @middle_range.min)
          base_price + remaining_price
        when @high_range
          puts "high!"
          base_price = @low_price * @middle_range.min
          base_price2 = @middle_price * (@middle_range.max - @middle_range.min)
          remaining_price = @high_price * (total_usage - @middle_range.max)
          base_price + base_price2 + remaining_price
        else
          raise "Invalid total usage: #{total_usage}"
        end
      end
    end

    private

      def calc_total_usage(usage)
        usage.inject(0) do |sum, usage_in_a_day|
          sum += usage_in_a_day.inject(:+)
        end
      end
  end
end
