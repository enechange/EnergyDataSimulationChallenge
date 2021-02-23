require './shogo_hori/lib/charges.rb'

class Simulator
  attr_reader :amps, :usage, :company

  def initialize(amps, usage, company)
    @amps = amps
    @usage = usage
    @company = company
  end

  def simulate
    charge = Charges.new(@amps, @usage)

    if @company == '東京電力エナジーパートナー'
      charge.tepco
    elsif @company == 'Looopでんき'
      charge.looop
    elsif @company == '東京ガス'
      charge.tokyo_gas
    end
  end
end

simulator = Simulator.new(40, 180, '東京電力エナジーパートナー')
puts simulator.simulate
