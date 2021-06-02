class Simulator
  attr_accessor :amp, :kwh

  def initialize(amp, kwh)
    @amp = amp
    @kwh = kwh
  end

  # プランごとの見積もりシュミレーションを実行し、結果を表示する
  def simulate(plans)

    result = []
    plans.map do |plan|
      
      # 基本料金の計算
      base_charge = plan.calc_base_charge(self.amp)

      # 従量料金の計算
      as_pay_charge = plan.calc_as_pay_charge(self.kwh)

      # 電気を全く使用していない場合、基本料金が半額になる
      if as_pay_charge == 0  
        base_charge = base_charge/2
      end
      
      # 電気料金 = 基本料金 + 従量料金(少数切り捨て)
      total_charge = (base_charge + as_pay_charge).floor
      
      # 電気料金が月額最低額以下の場合、月額最低額で電気料金を計上する
      # (現時点で東京電力エナジーパートナー 従量電灯Bのみ確認)
      if !plan.min_charge.nil? && plan.min_charge > total_charge
        total_charge = plan.min_charge.floor
      end

      result << {
        provider_name: plan.provider_name,
        plan_name: plan.name,
        price: plan.is_supported ? total_charge : 'アンペア対応外です'
      }
    end
    puts result
  end
end