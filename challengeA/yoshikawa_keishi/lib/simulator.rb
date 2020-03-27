class Simulator 
  attr_reader :amp, :usage
  @@plans = [
    {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", amperes: [10, 15, 20, 30, 40, 50, 60], rate: {0 => 19.88, 120 => 26.48, 300 => 30.57}, basicChargeRate: 28.6 },
    {provider_name: "東京ガス", plan_name: "ずっとも電気１", amperes: [30, 40, 50, 60], rate: {0 => 23.67, 140 => 23.88, 350 => 26.41}, basicChargeRate: 28.6 },
    {provider_name: "Looop電気", plan_name: "おうちプラン", amperes: [10, 15, 20, 30, 40, 50, 60], rate: {0 => 26.40}, basicChargeRate: 0 },
    # {provider_name: "吉川電気", plan_name: "お試しプラン", amperes: [50, 60], rate: {0 => 100.40}, basicChargeRate: 0 }
  ]
  $acceptableAmperes = []
  @@plans.each {|plan| $acceptableAmperes = $acceptableAmperes | plan[:amperes]}

  def initialize(amp, usage)
    @amp, @usage = amp, usage
  end

 # 価格の安い順に各プランを表示
  def simulate
    if $acceptableAmperes.include?(amp) && usage.is_a?(Integer) 
      output = []
      @@plans.each do |plan|
        output << {provider_name: plan[:provider_name], plan_name: plan[:plan_name], price: "#{basic_and_usageBased_charge(plan[:amperes], plan[:basicChargeRate], plan[:rate])}"}
      end
      print "#{output.sort{|a,b| a[:price] <=> b[:price]}}\n"
    elsif $acceptableAmperes.include?(amp)
      $stderr.puts "電気の使用量は整数を入力してください。(例) simulator = Simulator.new(30, 100)"
    else usage.is_a?(Integer)
      $stderr.puts "アンペアは10,15,20,30,40,50,60のうちから一つを選んで入力してください (例) simulator = Simulator.new(30, 100)"
    end
  end

  def basic_and_usageBased_charge(amperes, basicChargeRate, rate)
    return "ご指定のアンペアでのプランは用意されておりません" unless amperes.include?(amp)
    rate.sort{|a,b| a[0] <=> b[0]}
    totalCharge = basicChargeRate * amp + usageBasedCharge(rate.keys, rate.values)
  end

# 使用量によって変動する料金を各プランの従量制に基づいて計算する
  def usageBasedCharge keys, values
    keys.sort
    values.sort
    usageBasedCharge = 0
    i = 0
    (values.length - 1).times do 
      if usage >= keys[i + 1]
        usageBasedCharge += values[i] * (keys[i + 1] - keys[i])
        i += 1
      end
    end
    usageBasedCharge += values[i] * (@usage - keys[i])
  end

# 各プランを変更、拡張するクラスメソッド 
  def self.find_plans(name)
    @@plans.find{|hash| hash[:provider_name] === name}
  end
end




# プランの規格変更の例
Simulator.find_plans("東京電力エナジーパートナー")[:amperes].push(70)


simulator = Simulator.new(50, 300)
simulator.simulate





