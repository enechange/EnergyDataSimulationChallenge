class Simulator 
  attr_reader :amp, :usage
  @@EP_planB_SET = {amperes: [10, 15, 20, 30, 40, 50, 60], rate: {0 => 19.88, 120 => 26.48, 300 => 30.57}, basicChargeRate: 28.6 }
  @@TG_ZUTTOMO_SET = {amperes: [30, 40, 50, 60], rate: {0 => 23.67, 140 => 23.88, 350 => 26.41}, basicChargeRate: 28.6 }
  @@LOOOP_HOMEPLAN_SET = {amperes: [10, 15, 20, 30, 40, 50, 60], rate: {0 => 26.40}, basicChargeRate: 0 }
  $acceptableAmperes = @@EP_planB_SET[:amperes] || @@TG_ZUTTOMO_SET [:amperes] || @@LOOOP_HOMEPLAN_SET[:amperes]

  def initialize(amp, usage)
    @amp, @usage = amp, usage
  end

 # 価格の安い順に各プランを表示
  def simulate
    if $acceptableAmperes.include?(amp) && usage.is_a?(Integer) 
      output = [
        {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{basic_and_usageBased_charge(@@EP_planB_SET[:amperes], @@EP_planB_SET[:basicChargeRate], @@EP_planB_SET[:rate])}"},
        {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{basic_and_usageBased_charge(@@LOOOP_HOMEPLAN_SET [:amperes], @@LOOOP_HOMEPLAN_SET [:basicChargeRate], @@LOOOP_HOMEPLAN_SET [:rate])}"},
        {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{basic_and_usageBased_charge(@@TG_ZUTTOMO_SET[:amperes], @@TG_ZUTTOMO_SET[:basicChargeRate], @@TG_ZUTTOMO_SET[:rate])}"}
      ]
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
  class << self
    def EP_planB_SET
      @@EP_planB_SET
    end

    def TG_ZUTTOMO_SET
      @@TG_ZUTTOMO_SET
    end

    def LOOOP_HOMEPLAN_SET
      @@LOOOP_HOMEPLAN_SET
    end
  end
end




# プランの規格変更の例

# # 1kWhのあたりの料金設定を帰る
# Simulator.EP_planB_SET[:rate][0] = 20.00
# Simulator.EP_planB_SET[:rate].delete(120)
# Simulator.EP_planB_SET[:rate].update({350 => 50.00})
# # 基本料金が変わった時
# Simulator.EP_planB_SET[:basicChargeRate] = 10000.00
# # 申し込みできるアンペア数が変わった時
# Simulator.acceptableAmpere << 25


simulator = Simulator.new(10, 300)
simulator.simulate





