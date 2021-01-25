class Simulator 
  def simulate
    
    puts "契約アンペア(A)を(10, 15, 20, 30, 40, 50, 60)の中から入力して下さい"
    ampere = gets.to_i

    until [10, 15, 20, 30, 40, 50, 60].include?(ampere) 
      puts "エラー:契約アンペア(A)は(10, 15, 20, 30, 40, 50, 60)の中から入力して下さい。"
      ampere = gets.to_i
    end
 
    puts "使用量(kWh)を入力して下さい。"
    consumption = gets.to_i

    until consumption.positive?
      puts "エラー:使用量(kWh)は0より大きい数値を入力して下さい。"
      consumption = gets.to_i
    end


    # 各プランの料金を計算する
    priceList = PriceList.new(ampere, consumption)
    
    tepco_Price = priceList.tepco_Price.floor
    looop_Price = priceList.looop_Price.floor
    tokyo_gas_Price = [30,40,50,60].include?(ampere) ? priceList.tokyo_gas_Price.floor : nil
    # 新プランはここに追記
    # hoge_Price = priceList.hoge_Price.floor

    # 料金プラン
    pricePlan = [
      {provider_name: "東京エナジーパートナー", plan_name: "従量電灯B", price: "#{tepco_Price}"},
      {provider_name: "Looopでんき", plan_name: "おうちプラン", price: "#{looop_Price}"},
      {provider_name: "東京ガス", plan_name: "ずっとも電気1", price: "#{tokyo_gas_Price}"},
    ]

    # 新プランは上記の配列に追記
    # {provider_name: "hoge電気", plan_name: "hogeプラン", price: "#{hoge_Price}"},


    # 出力

    pricePlan.each do |plan|
      unless plan[:price].empty? then
        puts plan
      end
    end
       
  end

end

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
    if @consumption <= 120
      meterRate = @consumption * 19.88
    elsif @consumption > 120 && @consumption <= 300
      meterRate = @consumption * 26.48
    elsif @consumption > 300 
      meterRate = @consumption * 30.57
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
    if @consumption <= 140
      meterRate = @consumption * 23.67
    elsif @consumption > 140 && @consumption <= 350
      meterRate = @consumption * 23.88
    elsif @consumption > 350 
      meterRate = @consumption * 26.41
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
  #   if @consumption <= 140
  #     meterRate = @consumption * 23.67
  #   elsif @consumption > 140 && @consumption <= 350
  #     meterRate = @consumption * 23.88
  #   elsif @consumption > 350 
  #     meterRate = @consumption * 26.41
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

simulator = Simulator.new
simulator.simulate
