class SimulatorsController < ApplicationController
  def index
    # binding.pry
    @simulator = Simulator.new
  end
  def simulate
    binding.pry
    @simulator = Simulator.new(simulator_params)
    @simulation_results = @simulator.simulate
  end
  private
  def simulator_params
    params.require(:simulator).permit(:current, :power)
  end
end
