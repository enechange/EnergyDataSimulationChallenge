## simulator = Simulator.new(40, 280)
## simulator.simulate
#=> [{ provider_name: ‘Looopでんき’, plan_name: ‘おうちプラン’, price: ‘1234’ }, …]

# require 'json'

class Simulator

  def initialize(ampere, monthly_amount_kwh)
    @ampere = ampere
    @monthly_amount_kwh = monthly_amount_kwh
    suggest_plan
  end

  def simulate
    ## @plansをそのまま出力
  end

  private

  def suggest_plan
    @plans = []
    
  end
end