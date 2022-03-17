# rubocop:disable Metrics/AbcSize
# frozen_string_literal: true

require_relative 'company/jxtg_denki'
require_relative 'company/loop_denki'
require_relative 'company/tokyo_denryoku'
require_relative 'company/tokyo_gasu'

class Simulator
  class InValidAmpereError < StandardError; end
  class InValidKwhError < StandardError; end

  CONSTRUCTABLE_AMPERES = [10, 15, 20, 30, 40, 50, 60].freeze

  attr_accessor :ampere, :kwh

  def initialize(ampere:, kwh:)
    @ampere = ampere
    @kwh   = kwh
  end

  def simulator
    validate!

    puts Company::TokyoDenryoku.new(ampere:, kwh:).simulate_list
    puts Company::LoopDenki.new(ampere:, kwh:).simulate_list
    puts Company::TokyoGasu.new(ampere:, kwh:).simulate_list
    puts Company::JxtgDenki.new(ampere:, kwh:).simulate_list
  rescue StandardError => e
    puts "エラーが発生しました。#{e}"
  end

  private

  def validate!
    raise InValidAmpereError unless CONSTRUCTABLE_AMPERES.include?(ampere)
    raise InValidKwhError if !kwh.is_a?(Integer) || !kwh.positive?
  end
end
# rubocop:enable Metrics/AbcSize
