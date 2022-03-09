require_relative 'company/jxtg_denki'
require_relative 'company/loop_denki'
require_relative 'company/tokyo_denryoku'
require_relative 'company/tokyo_gasu'

class Simulator
  class InValidAmpereError < StandardError; end
  class InValidWattError < StandardError; end

  CONSTRUCTABLE_AMPERES = [10, 15, 20, 30, 40, 50, 60]

  attr_accessor :ampere, :watt

  def initialize(ampere:, watt:)
    @ampere = ampere
    @watt   = watt
  end

  def simulator
    validate!

    puts Company::TokyoDenryoku.new(ampere: ampere, watt: watt).simulate_list
    puts Company::LoopDenki.new(ampere: ampere, watt: watt).simulate_list
    puts Company::TokyoGasu.new(ampere: ampere, watt: watt).simulate_list
    puts Company::JxtgDenki.new(ampere: ampere, watt: watt).simulate_list
  rescue => e
    puts "エラーが発生しました。#{e}"
  end

  private

  def validate!
    raise InValidAmpereError unless CONSTRUCTABLE_AMPERES.include?(ampere)
    raise InValidWattError if !watt.is_a?(Integer) || !watt.positive?
  end
end

Simulator.new(ampere: 10, watt: 100).simulator
