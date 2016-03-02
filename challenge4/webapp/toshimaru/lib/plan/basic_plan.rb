module Plan
  class BasicPlan < PlanBase
    attr_reader :result

    def initialize(plan)
      parse_price_ranges(plan["Day time"])
    end

    def calc(usage)
      # puts "basic plan! #{usage}"

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

      def parse_price_ranges(price_ranges)
        middle_min, middle_max, @middle_price = price_ranges.second
        @low_price = price_ranges.first.last
        @high_price =  price_ranges.third.last

        @low_range = 0..middle_min
        @middle_range = middle_min..middle_max
        @high_range = middle_max..Float::INFINITY

        puts "#{@low_range} => #{@low_price}"
        puts "#{@middle_range} => #{@middle_price}"
        puts "#{@high_range} => #{@high_price}"
      end
  end
end
