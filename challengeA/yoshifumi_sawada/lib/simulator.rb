require "pry"
require_relative "plan"
require_relative "basic_charge"
require_relative "usage_charge"

class Simulator

  def initialize(amp,usage_per_week)
    @amp = amp
    @usage_per_week = usage_per_week
  end

  def simulate
    # プロバイダと料金プランのCSVデータをインポート
    csv_data = Plan.import(path: "csv/plans.csv")
    # 該当プランに計算結果(メソッドの返り値)のハッシュを追加・全プラン表示
    plan_list = csv_data.each do |data|
      case
      when data[:provider_name] == "東京電力エナジーパートナー"
        data[:price]= "#{self.calc_planA(@amp,@usage_per_week)}"
      when data[:provider_name] == "Looopでんき"
        data[:price]= "#{self.calc_planB(@amp,@usage_per_week)}"
      when data[:provider_name] == "東京ガス" && [30,40,50,60].include?(@amp)
        data[:price] = "#{self.calc_planC(@amp,@usage_per_week)}"
      end
    end
    # priceにデータが入ってるプランのみに絞り込み
    p output_array = plan_list.select{|plan| plan.has_key?(:price)}
  end

  #各プランごとに計算メソッドを定義
  private

  #東京電力エナジーパートナーの従量電灯Bの計算メソッド

  def calc_planA(amp,usage_per_week)

    #基本料金テーブルのCSVデータをインポート
    basic_charge_table = Basic_charge.import(path: "../csv/tokyo_energy_partner/basic_charge.csv")

    #入力値を含む料金データを取得
    charge_data = basic_charge_table.find { |data| data[:amp] == "#{amp}" }
    #データから値を取得
    basic_charge = charge_data[:basic_charge].to_i

    #電気量料金テーブルのCSVデータをインポート
    usage_charge_table = Usage_charge.import(path: "../csv/tokyo_energy_partner/usage_charge.csv")
    #計算で使用する単価を取得
    usage_charge_data1 = usage_charge_table.find { |data| data[:kwh] == "120" }
    usage_charge1 = usage_charge_data1[:unit_price].to_f

    usage_charge_data2 = usage_charge_table.find { |data| data[:kwh] == "300" }
    usage_charge2 = usage_charge_data2[:unit_price].to_f

    usage_charge_data3 = usage_charge_table.find { |data| data[:kwh] == "301" }
    usage_charge3 = usage_charge_data3[:unit_price].to_f

    usage_charge =
      if usage_per_week <= 120 then usage_charge1*usage_per_week
      elsif usage_per_week <= 300 then usage_charge1*120 + usage_charge2*(usage_per_week-120)
      elsif usage_per_week > 300 then usage_charge1*120 + usage_charge2*180 + usage_charge3*(usage_per_week-300)
      else '???'
      end

    ## 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end

  # Looopでんきのおうちプランの計算メソッド
  def calc_planB(amp,usage_per_week)

    #基本料金テーブルのCSVデータをインポート
    basic_charge_table = Basic_charge.import3(path: "../csv/loop/basic_charge.csv")
    #入力値を含む料金データを取得
    charge_data = basic_charge_table.find { |data| data[:amp] == "#{amp}" }
    #データから値を取得
    basic_charge = charge_data[:basic_charge].to_i

    #電気量料金テーブルのCSVデータをインポート
    usage_charge_table = Usage_charge.import2(path: "../csv/loop/usage_charge.csv")

    #計算で使用する単価を取得
    usage_charge_data = usage_charge_table.find { |data| data[:kwh] == "0" }
    unit_price = usage_charge_data[:unit_price].to_f

    usage_charge = usage_per_week*unit_price

    # 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end

    # 東京ガスのずっとも電気１の計算メソッド
  def calc_planC(amp,usage_per_week)

    #料金テーブルのCSVデータをインポート
    basic_charge_table = Basic_charge.import2(path: "../csv/tokyogas/basic_charge.csv")

    #入力値を含む料金データを取得
    charge_data = basic_charge_table.find { |data| data[:amp] == "#{amp}" }

    #データから値を取得
    basic_charge = charge_data[:basic_charge].to_i

    #電気量料金テーブルのCSVデータをインポート
    usage_charge_table = Usage_charge.import3(path: "../csv/tokyogas/usage_charge.csv")

    #計算で使用する単価を取得
    usage_charge_data1 = usage_charge_table.find { |data| data[:kwh] == "140" }

    unit_price1 = usage_charge_data1[:unit_price].to_f

    usage_charge_data2 = usage_charge_table.find { |data| data[:kwh] == "350" }
    unit_price2 = usage_charge_data2[:unit_price].to_f

    usage_charge_data3 = usage_charge_table.find { |data| data[:kwh] == "351" }
    unit_price3 = usage_charge_data3[:unit_price].to_f

    usage_charge =
    if usage_per_week <= 140 then unit_price1*usage_per_week
    elsif usage_per_week <= 350 then unit_price1*140 + unit_price2*(usage_per_week-140)
    elsif usage_per_week > 350 then unit_price1*140 + unit_price2*210 + unit_price3*(usage_per_week-350)
    else '???'
    end

    # 最後の評価式
    total_charge = (basic_charge + usage_charge).floor
  end
end


# #****************実行部分***************************************************************


## 契約アンペアを入力
while true
print "契約アンペアを入力して下さい > "
  amp = gets.to_i
  break if [10,15,20,30,40,50,60].include?(amp)
    puts "10,15,20,30,40,50,60のいずれかを入力して下さい"
end

## 1ヶ月あたりの使用量を入力
while true
print "1ヶ月あたりの使用量を入力して下さい > "
  usage_per_week = gets.to_i
  break if usage_per_week >= 0
    puts "0以上の値を入力して下さい"
end

# 入力値を引数にSimulatorクラスのインスタンスを生成
simulator = Simulator.new(amp,usage_per_week)
# インスタンスに対してsimulateメソッド(計算メソッド)を実行して出力結果を表示する
simulator.simulate