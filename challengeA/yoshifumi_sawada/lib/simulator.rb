require "pry"
require_relative "plan"
require_relative "basic_charge"
require_relative "usage_charge"

class Simulator

  def initialize(amp,usage_per_month)
    @amp = amp
    @usage_per_month = usage_per_month
  end

  def simulate
    # 東京電力エナジーパートナー従量電灯Bの電気量料金のCSVデータをインポート
    usage_datas = Usage_charge.import(path: "../csv/tokyo_energy_partner/usage_charge.csv")
    # 東京電力エナジーパートナーの従量電灯Bの電気量料金
    usage_charge1 = calculate(usage_datas)
    # 東京ガスのずっとも電気１の電気量料金の電気量料金テーブルのCSVデータをインポート
    usage_datas3 = Usage_charge.import3(path: "../csv/tokyogas/usage_charge.csv")
    # 東京ガスのずっとも電気１の電気量料金
    usage_charge3 = calculate(usage_datas3)

    # JXTGでんき 従量電灯B たっぷりプランの電気量料金の電気量料金テーブルのCSVデータをインポート
    usage_datas4 = Usage_charge.import4(path: "../csv/jxtg/usage_charge.csv")
    # 東京ガスのずっとも電気１の電気量料金
    usage_charge4 = calculate(usage_datas4)

    # Looopでんきのおうちプランの電気量料金テーブルのCSVデータをインポート
    usage_datas2 = Usage_charge.import2(path: "../csv/loop/usage_charge.csv")
    # Looopでんきのおうちプランの電気量料金の単価
    usage_charge_data2 = usage_datas2.find { |data| data[:kwh] == "0" }
    unit_price2 = usage_charge_data2[:unit_price].to_f


    # 基本料金テーブルのCSVデータをインポート
    basic_charge_table  = Basic_charge.import(path: "../csv/tokyo_energy_partner/basic_charge.csv")
    basic_charge_table2 = Basic_charge.import2(path: "../csv/loop/basic_charge.csv")
    basic_charge_table3 = Basic_charge.import3(path: "../csv/tokyogas/basic_charge.csv")
    basic_charge_table4 = Basic_charge.import4(path: "../csv/jxtg/basic_charge.csv")


    # プロバイダと料金プラン名のCSVデータをインポート
    plan_datas = Plan.import(path: "csv/plans.csv")

    # 該当プランに価格の計算結果のハッシュを追加
    plan_list = plan_datas.each do |data|
      case
      when data[:provider_name] == "東京電力エナジーパートナー"
      charge_data = basic_charge_table.find { |data| data[:amp] == "#{@amp}" }
      data[:price]= (charge_data[:basic_charge].to_i + usage_charge1).floor.to_s

      when data[:provider_name] == "Looopでんき"
      charge_data2 = basic_charge_table2.find { |data| data[:amp] == "#{@amp}" }
      data[:price]= (charge_data2[:basic_charge].to_i + @usage_per_month * unit_price2).floor.to_s

      when data[:provider_name] == "東京ガス" && [30,40,50,60].include?(@amp)
      charge_data3 = basic_charge_table3.find { |data| data[:amp] == "#{@amp}" }
      data[:price]= (charge_data3[:basic_charge].to_i + usage_charge3).floor.to_s

      when data[:provider_name] == "JXTGでんき" && [30,40,50,60].include?(@amp)
      charge_data4 = basic_charge_table4.find { |data| data[:amp] == "#{@amp}" }
      data[:price]= (charge_data4[:basic_charge].to_i + usage_charge4).floor.to_s
      end
    end

    # priceキーに値が入ってるプランのみを表示
    p output_array = plan_list.select{|plan| plan.has_key?(:price)}
  end

  private

  # 段階別料金プランの計算
  def calculate(usage_datas)
    usage_charge = 0
    usage_datas.each do |usage_data|
    if usage_data[:kwh_from].to_i < @usage_per_month && @usage_per_month <= usage_data[:kwh_to].to_i
      usage_charge = usage_charge + usage_data[:unit_price].to_f * (@usage_per_month - usage_data[:kwh_from].to_i)
    elsif usage_data[:kwh_to].to_i < @usage_per_month
      usage_charge = usage_charge + usage_data[:unit_price].to_f * (usage_data[:kwh_to].to_i - usage_data[:kwh_from].to_i)
    end
    end
  return usage_charge
  end
end

# #****************実行部分***************************************************************


# 契約アンペアを入力して頂く
while true
print "契約アンペアを入力して下さい > "
  amp = gets.to_i
  break if [10,15,20,30,40,50,60].include?(amp)
    puts "10,15,20,30,40,50,60のいずれかを入力して下さい"
end

# 1ヶ月あたりの使用量を入力して頂く
while true
print "1ヶ月あたりの使用量を入力して下さい > "
  usage_per_month = gets.to_i
  break if usage_per_month >= 0
    puts "0以上の値を入力して下さい"
end

# 入力値を引数にSimulatorクラスのインスタンスを生成
simulator = Simulator.new(amp,usage_per_month)

# インスタンスに対してsimulateメソッド(計算メソッド)を実行して出力結果を表示
simulator.simulate