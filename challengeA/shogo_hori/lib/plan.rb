require 'csv'

class Plan
  TEPCO = { provider_name: '東京電力エナジーパートナー',
            plan_name: '従量電灯B',
            basicChargeList: CSV.read(File.expand_path('./csv/tepco/basicCharge.csv')),
            usageChargeList: CSV.read(File.expand_path('./csv/tepco/usageCharge.csv'))}

  LOOOP = { provider_name: 'Looopでんき',
            plan_name: 'おうちでんきプラン',
            basicChargeList: CSV.read(File.expand_path('./csv/looop/basicCharge.csv')),
            usageChargeList: CSV.read(File.expand_path('./csv/looop/usageCharge.csv'))}

  TOKYO_GAS = { provider_name: '東京ガス',
                plan_name: 'ずっとも電気１',
                basicChargeList: CSV.read(File.expand_path('./csv/tokyo_gas/basicCharge.csv')),
                usageChargeList: CSV.read(File.expand_path('./csv/tokyo_gas/usageCharge.csv'))}

  # 【COMPANY】 = { provider_name: '【会社名】',
  #               plan_name: '【プラン】',
  #               basicChargeList: CSV.read('./csv/【company】/basicCharge.csv'),
  #               usageChargeList: CSV.read('./csv/【company】/usageCharge.csv')}
end
