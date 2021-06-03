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
      total_charge = plan.calc_total_charge(self.amp, self.kwh)
      result << {
        provider_name: plan.provider_name,
        plan_name: plan.name,
        price: plan.is_supported ? total_charge : 'アンペア対応外です'
      }
    end
    
    puts result
  end
end