# frozen_string_literal: true

require './lib/simulator'

simulator = Simulator.new(40, 280)
result = simulator.simulate
puts result
