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
      
      base_charge = plan.calc_base_charge(self.amp)
      as_pay_charge = plan.calc_as_pay_charge(self.kwh)

      # 電気料金 = 基本料金 + 従量料金
      total_charge = base_charge + as_pay_charge

      result << {
        provider_name: plan.provider_name,
        plan_name: plan.name,
        price: total_charge.ceil
      }
    end
    puts result
  end
end