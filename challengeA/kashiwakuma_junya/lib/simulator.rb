class Simulator
  PROVIDER_PLAN = { '東京電力' => '従量電灯B', 'looop' => 'おうちプラン', '東京ガス' => '東京ガスずっとも電気' }.freeze
  def initialize(contractamps, use_kwh)
    @contractamps = contractamps
    @use_kwh    = use_kwh
  end

  def simulate
    result = []
    PROVIDER_PLAN.each do |provider_name, plan_name|
      calculate = Calculate.new(provider_name, @contractamps, @use_kwh)
      result << { "provider_name" => provider_name, "plan_name" => plan_name, "price" => calculate.price.floor }
    end
    print result
  end
end

class Calculate
  def initialize(provider, contractamps, usage_kwh)
    @provider = provider
    @contractamps = contractamps
    @usage_kwh = usage_kwh
    @tax = 1.1
  end

  def price
    contactamps_prise = Contract.amps(@provider)
    base_price = 0
    contactamps_prise.each { |k, v| base_price = v if k === @contractamps }
    if @usage_kwh == 0
      ( base_price / 2 ) * @tax
    else
      ( base_price + pay_for_use_price ) * @tax
    end
  end

  private
  def pay_for_use_price
    case @provider
    when '東京電力'
      if @usage_kwh <= 120
        @usage_kwh * 19.88
      elsif @usage_kwh > 120 && @usage_kwh <= 300
        price = 120 * 19.88 + ( @usage_kwh - 120 ) * 26.48
      elsif @usage_kwh > 300
        120 * 19.88 + 180 * 26.48 + ( @usage_kwh - 300 ) * 30.57
      end
    when 'looop'
      @usage_kwh * 26.40
    when '東京ガス'
      if @usage_kwh <= 140
        @usage_kwh * 23.67
      elsif @usage_kwh > 140 && @usage_kwh <= 350
        140 * 23.67 + ( @usage_kwh - 140 ) * 23.88
      elsif @usage_kwh > 350
        140 * 23.67 + 210 * 23.88 + ( @usage_kwh - 350 ) * 26.41
      end
    end
  end
end

class Contract
  def self.amps(provider)
    case provider
    when '東京電力'
      { 10 => 286.00, 15 => 429.00, 20 => 572.00, 30 => 858.00, 40 => 1144.00, 50 => 1430.00, 60 => 1716.00 }
    when 'looop'
      { 10 => 0.00, 15 => 0.00, 20 => 0.00, 30 => 0.00, 40 => 0.00, 50 => 0.00, 60 => 0.00 }
    when '東京ガス'
      { 10 => 0.00, 15 => 0.00, 20 => 0.00, 30 => 0.00, 40 => 1144.00, 50 => 1430.00, 60 => 1716.00 }
    end
  end
end
