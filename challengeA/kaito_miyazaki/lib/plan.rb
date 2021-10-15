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

    # Charge（料金）クラスのサブクラスのインスタンスを要素とする配列
    @charges = []
    charge_rules.each_key do |rule_name|
      # ..._ruleの...の部分を取り出し，パスカルケース化したもの
      class_name = rule_name[/(.*)_rule/, 1].split('_').collect(&:capitalize).join
      # class_nameクラスのインスタンスを作成し，配列の要素とする
      @charges << Object.const_get(class_name).new(charge_rules[rule_name])
    end
  end

  # 料金（基本料金と従量料金の和）の計算用メソッド
  # conditions：ユーザー側の条件（hash）
  # 例：{ amp: 10, kwh: 100 }（契約アンペア数[A]が10，使用量[kWh]が100の場合）
  def price(conditions)
    result = 0
    @charges.each do |charge|
      result += charge.calculate(conditions)
    end
    result
  end
end
