require_relative 'calculate.rb'
require_relative 'contract.rb'

class Simulator
  PROVIDER_PLAN = { '東京電力' => '従量電灯B', 'looop' => 'おうちプラン', '東京ガス' => '東京ガスずっとも電気' }.freeze
  CONTRACT_AMP = [ 10, 15, 20, 30, 40, 50, 60]
  def initialize(contract_amp, use_kwh)
    if CONTRACT_AMP.include?(contract_amp)
      @contract_amp = contract_amp
    else
      puts '契約電力は10,15,20,30,40,50,60のいずれかで入力してください'
      exit
    end
    if use_kwh >= 0
      @use_kwh  = use_kwh
    else
      puts '使用量は0以上で入力してください'
      exit
    end
  end

  def simulate
    result = PROVIDER_PLAN.map do |provider_name, plan_name|
      calculate = Calculate.new(provider_name, @contract_amp, @use_kwh)
      { "provider_name" => provider_name, "plan_name" => plan_name, "price" => calculate.price }
    end
    print result
  end
end

# 以下実行例
# ruby lib/simulator.rbで実行すると以下コードが実行され、結果が標準出力に表示される
s = Simulator.new(10, 50)
s.simulate