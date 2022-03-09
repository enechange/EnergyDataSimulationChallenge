# rubocop:disable Metrics/AbcSize
# frozen_string_literal: true

require_relative 'company/jxtg_denki'
require_relative 'company/loop_denki'
require_relative 'company/tokyo_denryoku'
require_relative 'company/tokyo_gasu'

class Simulator
  class InValidAmpereError < StandardError; end
  class InValidWattError < StandardError; end

  CONSTRUCTABLE_AMPERES = [10, 15, 20, 30, 40, 50, 60].freeze

  attr_accessor :ampere, :watt

  def initialize(ampere:, watt:)
    @ampere = ampere
    @watt   = watt
  end

  def simulator
    puts Company::TokyoDenryoku.new(ampere:, watt:).simulate_list
    puts Company::LoopDenki.new(ampere:, watt:).simulate_list
    puts Company::TokyoGasu.new(ampere:, watt:).simulate_list
    puts Company::JxtgDenki.new(ampere:, watt:).simulate_list
  rescue StandardError => e
    puts "エラーが発生しました。#{e}"
  end

  private

  def validate!
    raise InValidAmpereError unless CONSTRUCTABLE_AMPERES.include?(ampere)
    raise InValidWattError if !watt.is_a?(Integer) || !watt.positive?
  end
end
# rubocop:enable Metrics/AbcSize

Simulator.new(ampere: 10, watt: 100).simulator
