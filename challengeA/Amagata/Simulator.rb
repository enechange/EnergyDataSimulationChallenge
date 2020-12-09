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
      if array[:contract_current].include?(@ampare)
        # 基本料金を定義 アンペアがbasic_chargeにあればその基本料金料金、なければ0
        if info.basic_charge[:"#{@ampare}A"]
          basic = info.basic_charge[:"#{@ampare}A"]
        else
          basic = 0
        end
        # 単価決定の条件式1 
        if array[:range][0]<= @kilowatt_hour && @kilowatt_hour < array[:range][1]
          # 料金=基本料金+従量課金
          sum = basic + array[:pay_per_use][0] * @kilowatt_hour
        # 単価決定の条件式2
        elsif @kilowatt_hour >= array[:range][1] && @kilowatt_hour < array[:range][2]
          sum = basic + array[:pay_per_use][1] * @kilowatt_hour
        # 単価決定の条件式3
        else
          sum = basic + array[:pay_per_use][2] * @kilowatt_hour
        end
      else
        sum = 0
      end
      price << sum
    end

    # 料金の計算結果の個数だけ会社とプラント料金を、配列@resultsに入れる。
    @results=[]
    price.length.times do |i|
      if price[i] != 0
        @results << { provider_name: "#{arrays_all[i][:provider_name]}", plan_name: "#{arrays_all[i][:plan_name]}", price: "#{price[i]}" }
      end
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
    @basic_charge_tokyo= { 
      "10A": 286,
      "15A": 429,
      "20A": 572,
      "30A": 858,
      "40A": 1144,
      "50A": 1430,
      "60A": 1716 
    }
  end


  # 以下、[会社名、プラン名、レンジ、従量料金]
  def tepco
    @tepco = {
      "provider_name": "TEPCO",
      "plan_name": "従量電灯B",
      "range": [0,120,300],
      "pay_per_use": [19.88,26.48,30.57],
      "contract_current": [30,40,50,60]
    }
  end

  def  loooop
    @loooop = {
      "provider_name": "Loooop",
      "plan_name": "おうちプラン",
      "range": [0,0,0],
      "pay_per_use": [26.40,26.40,26.40],
      "contract_current": [*10..60]
    }
  end

  def  tokyo_gas
    @tokyo_gas = {
      "provider_name": "Tokyo gas",
      "plan_name": "ずっとも電気１",
      "range": [0,140,350],
      "pay_per_use": [23.67,23.88,26.41],
      "contract_current": [10,15,20,30,40,50,60]
    }
  end
#追加用
  # def amagata
  #   @amagata={
  #     "provider_name": "amagata",
  #     "plan_name": "amagataplan",
  #     "range": [0,200,500],
  #     "pay_per_use": [10,20,30]
  #     "contract_current": ["10A","50A","60A"]
  #   }
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
