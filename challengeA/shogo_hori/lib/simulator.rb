require_relative './charges'
require_relative './plan'

class Simulator
  attr_reader :amps, :usage

  def initialize(amps, usage)
    if !(amps?(amps)) && !(number?(usage))
      puts "アンペアは10, 15, 20, 30, 40, 50, 60中から入力ください。\n使用量は0以上の数値で入力ください。"
    elsif !(number?(usage))
      puts '使用量は0以上の数値で入力ください。'
    elsif !(amps?(amps))
      puts 'アンペアは10, 15, 20, 30, 40, 50, 60中から入力ください。'
    else
      @amps = amps
      @usage = usage
    end
  end

  def simulate
    charge = Charges.new(@amps, @usage)
    plans = []
    plans << { provider_name: Plan::TEPCO[:provider_name], plan_name: Plan::TEPCO[:plan_name], price: charge.tepco.to_s }
    plans << { provider_name: Plan::LOOOP[:provider_name], plan_name: Plan::LOOOP[:plan_name], price: charge.looop.to_s }
    plans << { provider_name: Plan::TOKYO_GAS[:provider_name], plan_name: Plan::TOKYO_GAS[:plan_name], price: charge.tokyo_gas.to_s } if [30, 40, 50, 60].include?(@amps)
    # plans << { provider_name: 【電力会社】, plan_name: 【プラン】, price: 【電気料金】 }

    plans.each do |plan|
      puts plan
    end
  end

  private

  def number?(usage)
    nil != (usage.to_s =~ /\A([1-9]\d*|0)(\.\d+)?\z/)
  end

  def amps?(amps)
    [10, 15, 20, 30, 40, 50, 60].include?(amps)
  end
end

simulator = Simulator.new(40, 180)
simulator.simulate