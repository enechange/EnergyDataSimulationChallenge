# 料金表のクラス
class PriceList
  # 契約アンペア(A)
  @ampere = nil
  # 使用量(kWh)
  @consumption = nil
  
  def initialize(ampere, consumption)
    @ampere = ampere
    @consumption = consumption   
  end

  # 東京電力エナジーパートナー 従量電灯B
  def tepco_Price
    
    # 基本料金
    basicPrice = basicPriceCaluculate
      
    # 従量料金

    # 第一段階
    if @consumption <= 120
      meterRate = @consumption * 19.88
    
    # 第二段階
    elsif @consumption > 120 && @consumption <= 300
      # 第一段階までの従量料金
      meterRate = 120 * 19.88

      meterRate = meterRate + (@consumption - 120) * 26.48

    # 第三段階
    elsif @consumption > 300
      # 第一段階までの従量料金
      meterRate = 120 * 19.88
      # 第二段階までの従量料金
      meterRate = meterRate + 180 * 26.48 

      meterRate =  meterRate + (@consumption - 300) * 30.57
    end

    # 電気料金
    totalPrice = basicPrice + meterRate

  end

  # Looopでんきおうちプラン
  def looop_Price

    # 基本料金(基本料金は0)
    basicPrice = 0
      
    # 従量料金
    meterRate = @consumption * 26.40

    # 電気料金
    totalPrice = basicPrice + meterRate

  end

  # 東京ガスずっとも電気１
  def tokyo_gas_Price
    
    # 基本料金
    basicPrice = basicPriceCaluculate
      
    # 従量料金

    # 第一段階
    if @consumption <= 140
      meterRate = @consumption * 23.67
    
    # 第二段階
    elsif @consumption > 140 && @consumption <= 350
      # 第二段階までの従量料金
      meterRate = 140 * 23.67

      meterRate = meterRate + (@consumption - 140) * 23.88

    # 第三段階
    elsif @consumption > 350
      # 第一段階までの従量料金
      meterRate = 140 * 23.67
      # 第二段階までの従量料金
      meterRate = meterRate + 210 * 23.88 

      meterRate =  meterRate + (@consumption - 350) * 26.41
    end

    # 電気料金
    totalPrice = basicPrice + meterRate

  end

  # 新プランはここに追記(従量料金の数値を変更する)

  # # hoge電気
  # def hoge_Price

  #   # 基本料金
  #   basicPrice = basicPriceCaluculate
  
  #   # 従量料金

  #   # 第一段階
  #   if @consumption <= 140
  #     meterRate = @consumption * 23.67
    
  #   # 第二段階
  #   elsif @consumption > 140 && @consumption <= 350
  #     # 第二段階までの従量料金
  #     meterRate = 140 * 23.67

  #     meterRate = meterRate + (@consumption - 140) * 23.88

  #   # 第三段階
  #   elsif @consumption > 350
  #     # 第一段階までの従量料金
  #     meterRate = 140 * 23.67
  #     # 第二段階までの従量料金
  #     meterRate = meterRate + 210 * 23.88 

  #     meterRate =  meterRate + (@consumption - 350) * 26.41
  #   end

  #   # 電気料金
  #   totalPrice = basicPrice + meterRate

  # end

  # 基本料金の計算
  def basicPriceCaluculate
  
    case @ampere
    when 10 then
    286.00
    when 15 then 
    429.00
    when 20 then 
    572.00
    when 30 then 
    858.00
    when 40 then 
    1144.00
    when 50 then 
    1430.00
    when 60 then 
    1716.00
    end

  end


end
