require 'csv'

class Plan
  attr_reader :amps, :usage

  def initialize(amps, usage)
    @amps = amps
    @usage = usage
  end

  TEPCO = { provider_name: '東京電力エナジーパートナー',
            plan_name: '従量電灯B',
            basicChargeList: CSV.read(File.expand_path('./csv/tepco/basicCharge.csv')),
            usageChargeList: CSV.read(File.expand_path('./csv/tepco/usageCharge.csv')) }.freeze

  LOOOP = { provider_name: 'Looopでんき',
            plan_name: 'おうちでんきプラン',
            basicChargeList: CSV.read(File.expand_path('./csv/looop/basicCharge.csv')),
            usageChargeList: CSV.read(File.expand_path('./csv/looop/usageCharge.csv')) }.freeze

  TOKYOGAS = { provider_name: '東京ガス',
               plan_name: 'ずっとも電気１',
               basicChargeList: CSV.read(File.expand_path('./csv/tokyogas/basicCharge.csv')),
               usageChargeList: CSV.read(File.expand_path('./csv/tokyogas/usageCharge.csv')) }.freeze

  # 【COMPANY】 = { provider_name: '【会社名】',
  #               plan_name: '【プラン】',
  #               basicChargeList: CSV.read('./csv/【company】/basicCharge.csv'),
  #               usageChargeList: CSV.read('./csv/【company】/usageCharge.csv')}.freeze
end
