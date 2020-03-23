class Simulator 

  def initialize(amp, usage)
    @amp = amp
    @usage = usage
  end

  # 価格の安い順に各プランを表示

  def simulate
    output = [
      {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{ep_planB}"},
      {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{looop_homePlan}"},
      {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{zuttomoDenki1}"}
    ]
    output.sort{|a,b| a[:price] <=> b[:price]}.each do |h|
      puts h
    end
  end

  # プラン毎にメソッドを用意、rateは使用量に応じて変動する１kWh１あたりの価格、levelはその段階が変わる使用量を示す

  def ep_planB
    basicCharge = 28.6 * @amp
    rate = {"1" => 19.88, "2" => 26.48, "3" => 30.57}
    level = {"1" => 120, "2" => 300}
    totalCharge = basicCharge + usageBasedCharge(level, rate)
  end

  def looop_homePlan
    usageBasedCharge = @usage * 26.40
  end

  def zuttomoDenki1
    amp = @amp < 30? 30 : @amp
    basicCharge = 28.6 * amp
    rate = {"1" => 23.67, "2" => 23.88, "3" => 26.41}
    level = {"1" => 140, "2" => 350}
    totalCharge = basicCharge + usageBasedCharge(level, rate)
  end

  # 使用量によって変動する料金を各プランの従量制に基づいて計算する

  def usageBasedCharge(level, rate)
    each_level_usage =
      case @usage
        when 0..level["1"]
          [level["1"]]
        when level["1"]..level["2"]
          [level["1"], @usage - level["1"]]
        else
          [level["1"], level["2"] - level["1"], @usage - level["2"]]
      end

    usageBasedCharge = 0
    each_level_usage.each_with_index do |n, index|
      index += 1
      usageBasedCharge += n * rate["#{index}"]
    end

    return usageBasedCharge.floor
  end
end


#　ファイルを実行したのち、入力されたものからデータを返す
puts "契約しているアンペア数を10, 15, 20, 30, 40, 50, 60のうちから入力してください（例）契約しているのが40Aなら \"40\""
input = gets.chomp.to_i 
until [10, 15, 20, 30, 40, 50, 60].include?(input)
  puts "10, 15, 20, 30, 40, 50, 60のうちから入力してください" 
  input = gets.chomp.to_i
end

puts "一ヶ月の使用料（kWh)を整数で入力してください（例）400kWhなら \"400\""
input2 = gets.chomp
until input2 =~ /[0-9]+/
  puts "整数を入力してください"
  input2 = gets.chomp
end

simulator = Simulator.new(input, input2.to_i)
simulator.simulate
