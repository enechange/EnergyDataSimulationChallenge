
require 'spec_helper'
require 'simulation'

describe "Simulation" do
  it "is initialized"  do

    simulation = Simulation.new(40, 280)

    expect(simulation.ampere).to eq(40)
    expect(simulation.usage).to eq(280)
  end

  it "is simulated" do

    simulation = Simulation.new(40, 280)

    expect(simulation.simulate).to eq([7766,7392,])
  end


end
