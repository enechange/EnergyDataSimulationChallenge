require_relative 'contract.rb'
class Calculate
  def initialize(provider, contract_amp, use_kwh)
    @provider = provider
    @contract_amp = contract_amp
    @use_kwh = use_kwh
    @tax = 1.1
  end

  def price
    contact_amp_prise = Contract.amp_price(@provider)
    base_price = 0
    contact_amp_prise.each { |k, v| base_price = v if k == @contract_amp }
    if @use_kwh == 0
      # 使用量が0の場合は基本料金は半額。小数点以下切り捨て
      (( base_price / 2 ) * @tax ).floor
    else
      # 小数点以下切り捨て
      (( base_price + mesured_rate_price ) * @tax ).floor
    end
  end

  private
  def mesured_rate_price
    case @provider
    when '東京電力'
      if @use_kwh <= 120
        @use_kwh * 19.88
      elsif @use_kwh > 120 && @use_kwh <= 300
        price = 120 * 19.88 + ( @use_kwh - 120 ) * 26.48
      elsif @use_kwh > 300
        120 * 19.88 + 180 * 26.48 + ( @use_kwh - 300 ) * 30.57
      end
    when 'looop'
      @use_kwh * 26.40
    when '東京ガス'
      if @use_kwh <= 140
        @use_kwh * 23.67
      elsif @use_kwh > 140 && @use_kwh <= 350
        140 * 23.67 + ( @use_kwh - 140 ) * 23.88
      elsif @use_kwh > 350
        140 * 23.67 + 210 * 23.88 + ( @use_kwh - 350 ) * 26.41
      end
    end
  end
end
