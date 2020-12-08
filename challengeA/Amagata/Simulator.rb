# 計算するクラス
class Calculator
  def initialize(ampare,kilowatt_hour)
    @ampare=ampare
    @kilowatt_hour=kilowatt_hour
  end

  def calculate
    # Informationクラスをインスタンス化
    info=Information.new
    # informationクラスのゲッターを配列に入れる。（手動）
    arrays_all=[info.tepco,info.loooop,info.tokyo_gas]  # 会社を追加した場合ここに新料金を足さなければならない。,info.amagata
    price=[]
    # 条件から各社料金を計算
    arrays_all.each do |array|
      # 基本料金を定義
      basic = info.basic_charge["#{@ampare}A"]
      # 単価決定の条件式1
      if array[2][0]<= @kilowatt_hour && @kilowatt_hour < array[2][1]
        sum = basic + array[3][0] * @kilowatt_hour
      # 単価決定の条件式2
      elsif @kilowatt_hour >= array[2][1] && @kilowatt_hour < array[2][2]
        sum = basic + array[3][1] * @kilowatt_hour
      # 単価決定の条件式3
      else
        sum = basic + array[3][2] * @kilowatt_hour
      end
      price << sum
    end

    # 料金の計算結果の個数だけ会社とプラント料金を、配列@resultsに入れる。
    @results=[]
    price.length.times do |i|
      @results << { provider_name: "#{arrays_all[i][0]}", plan_name: "#{arrays_all[i][1]}", price: "#{price[i]}" }
    end
  end
  # 結果ゲッター
  def results
    @results
  end
end

# 各情報のクラス
class Information
  #東京の基本料金
  def basic_charge
    @basic_charge_tokyo= { "10A" => 286, "15A" => 429, "20A" => 572,"30A" => 858, "40A" => 1144, "50A" => 1430, "60A" => 1716 }
  end
  # 以下、[会社名、プラン名、レンジ、従量料金]
  def tepco
    @tepco = ["TEPCO","従量電灯B",[0,120,300],[19.88,26.48,30.57]]
  end

  def  loooop
    @loooop = ["Loooop","おうちプラン",[0,0,0],[26.40,26.40,26.40]]
  end

  def  tokyo_gas
    @tokyo_gas = ["Tokyo gas","ずっとも電気１",[0,140,350],[23.67,23.88,26.41]]
  end
#追加用
  # def amagata
  #   @amagata=["amagata","amagataplan",[0,200,500],[10,20,30]]
  # end
end

# シミュレートする
class Simulator
  def simulate
    # 区分を入力
    p "契約アンペアを入力してください(A)"
    ampare = gets.to_i
    # 使用電力入力
    p "1ヶ月の電力使用料を入力してください(kWh)"
    kilowatt_hour= gets.to_i
    # 計算するクラスをインスタンス化
    calc=Calculator.new(ampare,kilowatt_hour)
    calc.calculate
    # 結果を表示する
    p calc.results
  end
end

# シミュレーターの実行
simulator = Simulator.new
simulator.simulate
