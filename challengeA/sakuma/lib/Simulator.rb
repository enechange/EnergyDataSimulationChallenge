require "./PriceList.rb"

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

    if consumption.negative?
      puts "エラー:使用量(kWh)は0以上の数値を入力して下さい。"
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


simulator = Simulator.new
simulator.simulate

# Ver5.0
# 従量料金の計算方法を三段階料金制度に修正
# SimulatorクラスとPriceListクラスに分離
# PriceListの電気料金の計算方法に対し、minitestを追加
