module Plan
  class PlanBase
    attr_accessor :name
    attr_reader :price

    def calc
      raise NotImplementedError
    end

    def as_json(options={})
      {
        name: name,
        price: price.to_i,
      }
    end

    private

    def parse_daytime_price_ranges(price_ranges)
      middle_min, middle_max, @middle_price = price_ranges.second
      @low_price = price_ranges.first.last
      @high_price =  price_ranges.third.last

      @low_range = 0..middle_min
      @middle_range = middle_min..middle_max
      @high_range = middle_max..Float::INFINITY

      Rails.logger.debug "#{@low_range} => #{@low_price}"
      Rails.logger.debug "#{@middle_range} => #{@middle_price}"
      Rails.logger.debug "#{@high_range} => #{@high_price}"
    end

    def calc_price(usage)
      case usage
      when @low_range
        Rails.logger.debug "low!"
        @low_price * usage
      when @middle_range
        Rails.logger.debug "middle!"
        base_price = @low_price * @middle_range.min
        remaining_price = @middle_price * (usage - @middle_range.min)
        base_price + remaining_price
      when @high_range
        Rails.logger.debug "high!"
        base_price = @low_price * @middle_range.min
        base_price2 = @middle_price * (@middle_range.max - @middle_range.min)
        remaining_price = @high_price * (usage - @middle_range.max)
        base_price + base_price2 + remaining_price
      else
        raise "Invalid total usage: #{usage}"
      end
    end
  end
end
