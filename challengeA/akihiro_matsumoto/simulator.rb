class Simulator
  def initialize(amp,kwh)
    @amp = amp
    @kwh = kwh
  end

  # プランを表示
  def simulate
    plans = [
      {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{juuryoudentouB}"},
      {provider_name: "Looopでんき", plan_name: "おうちプラン", price: "#{outiplan}"},
      {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{zuttomodennki1}"}
    ]

    plans.each do |plan|
      puts plan
    end
  end

  # 契約アンペア数１Aあたりの基本料金単価
  BASIC_CHARGE_UNIT_PRICE = 28.6

  # 東京電力エナジーパートナー 従量電灯B
  def juuryoudentouB
    # 基本料金 = １Aあたりの基本料金単価 × 契約アンペア数
    basic_charge = BASIC_CHARGE_UNIT_PRICE * @amp
    # 1ヶ月の使用量に応じた従量料金単価の条件分岐
    if @kwh <= 120
      variable_charge_unit_price = 19.88
    elsif @kwh > 120 && @kwh <= 300
      variable_charge_unit_price = 26.48
    elsif @kwh > 300
      variable_charge_unit_price = 30.57
    end
    # 従量料金 = 従量料金単価 × 電気使用量(kWh)
    variable_charge = variable_charge_unit_price * @kwh
    # 電気料金 = 基本料金 + 従量料金
    total_charge = basic_charge + variable_charge
  end

  # Looopでんき おうちプラン
  def outiplan
    # 基本料金は0円
    basic_charge = 0
    # 使用量に関わらず1kWhあたりの従量料金単価は26.4円
    variable_charge_unit_price = 26.4
    # 従量料金 = 従量料金単価 × 電気使用量(kWh)
    variable_charge = variable_charge_unit_price * @kwh
    # 電気料金 = 基本料金 + 従量料金
    total_charge = basic_charge + variable_charge
  end

  # 東京ガス ずっとも電気１
  def zuttomodennki1
    # 基本料金 = 1Aあたりの基本料金単価 × 契約アンペア数
    basic_charge = BASIC_CHARGE_UNIT_PRICE * @amp
    # 1ヶ月の使用量に応じた従量料金単価の条件分岐
    if @kwh <= 140
      variable_charge_unit_price = 23.67
    elsif @kwh > 140 && @kwh <= 350
      variable_charge_unit_price = 23.88
    elsif @kwh > 350
      variable_charge_unit_price = 26.41
    end
    # 従量料金 = 従量料金単価 × 電気使用量(kWh)
    variable_charge = variable_charge_unit_price * @kwh
    # 電気料金 = 基本料金 + 従量料金
    total_price = basic_charge + variable_charge
  end
end


  # 契約アンペアを入力
  puts <<~TEXT
  契約しているアンペア数を入力して下さい。
  （例：30Aの場合は"30"と入力してください）
  TEXT

  while true
    print "アンペア数を入力 > "
    amp = gets.to_i
    break if [10, 15, 20, 30, 40, 50, 60].include?(amp)
    puts "10,15,20,30,40,50,60のいずれかを入力して下さい"
  end

  # 電気使用量を入力
  puts <<~TEXT
  次に1ヶ月の電気使用量(kWh)を入力してください。
  （例：300kWhの場合は"300"と入力してください）
  TEXT
  
  while true
    print "電気使用量を入力 > "
    kwh = gets.to_i
    break if kwh > 0
    puts "電気使用量は0以上の数値で入力してください"
  end


simulator = Simulator.new(amp,kwh)
simulator.simulate