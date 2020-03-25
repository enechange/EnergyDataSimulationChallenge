class Simulator 
  attr_reader :amp, :usage
  @@EP_planB_SET = {rate: {0 => 19.88, 120 => 26.48, 300 => 30.57}, basicChargeRate: 28.6 }
  @@TG_ZUTTOMO_SET = {rate: {0 => 23.67, 140 => 23.88, 350 => 26.41}, basicChargeRate: 28.6 }
  @@LOOOP_HOMEPLAN_SET = {basicChargeRate: 26.40 }
  @@acceptableAmperes = [10, 15, 20, 30, 40, 50, 60]

  def initialize(amp, usage)
    @amp, @usage = amp, usage
  end

 # 価格の安い順に各プランを表示
  def simulate
    if @@acceptableAmperes.include?(amp) && usage.is_a?(Integer) 
      output = [
        {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{ep_planB_bill}"},
        {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{looop_homePlan_bill}"},
        {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{tg_zuttomoDenki1_bill}"}
      ]
      print "#{output.sort{|a,b| a[:price] <=> b[:price]}}\n"
    elsif @@acceptableAmperes.include?(amp)
      $stderr.puts "電気の使用量は整数を入力してください。(例) simulator = Simulator.new(30, 100)"
    else usage.is_a?(Integer)
      $stderr.puts "アンペアは10,15,20,30,40,50,60のうちから一つを選んで入力してください (例) simulator = Simulator.new(30, 100)"
    end
  end

# 東京電力エネルギーパートナー従量電灯B
  def ep_planB_bill
    @@EP_planB_SET[:rate].sort{|a,b| a[0] <=> b[0]}
    totalCharge = @@EP_planB_SET[:basicChargeRate] * amp + usageBasedCharge(@@EP_planB_SET[:rate].keys, @@EP_planB_SET[:rate].values)
    return totalCharge.floor
  end
# Looopeおうち電気プラン
  def looop_homePlan_bill
    usageBasedCharge = (@usage * @@LOOOP_HOMEPLAN_SET[:basicChargeRate])
    return usageBasedCharge.floor
  end
# 東京ガスずっとも電気１
  def tg_zuttomoDenki1_bill
    @@TG_ZUTTOMO_SET[:rate].sort{|a,b| a[0] <=> b[0]}
    new_amp = amp < 30? 30 : amp
    totalCharge = @@TG_ZUTTOMO_SET[:basicChargeRate] * new_amp + usageBasedCharge(@@TG_ZUTTOMO_SET[:rate].keys, @@TG_ZUTTOMO_SET[:rate].values)
    return totalCharge.floor
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

    def acceptableAmperes
      @@acceptableAmperes
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





