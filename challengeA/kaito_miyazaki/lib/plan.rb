# frozen_string_literal: true

require_relative 'basic_charge'
require_relative 'usage_charge'

# プランクラス
class Plan
  attr_reader :name

  # charge_rulesの例：{ 'basic_charge_rule' => { 10 => 123, 20 => 456, ... },
  #                    'usage_charge_rule' => { 100 => 12, 200 => 34, ... } }
  def initialize(name, charge_rules)
    @name = name
    @basic_charge = BasicCharge.new(charge_rules['basic_charge_rule'])
    @usage_charge = UsageCharge.new(charge_rules['usage_charge_rule'])
  end

  # 料金（基本料金と従量料金の和）の計算用メソッド
  # 引数：（順に）契約アンペア数（整数），使用量（整数）
  def price(amp, kwh)
    @basic_charge.calculate(amp) + @usage_charge.calculate(kwh)
  end
end
