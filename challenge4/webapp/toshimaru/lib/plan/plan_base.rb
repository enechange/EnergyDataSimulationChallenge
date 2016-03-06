module Plan
  class PlanBase
    attr_accessor :name
    attr_reader :result

    def calc
      raise NotImplementedError
    end

    def as_json(options={})
      {
        name: name,
        price: result.to_i,
      }
    end

    def parse_daytime_price_ranges(price_ranges)
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
