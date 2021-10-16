# frozen_string_literal: true

# 料金クラス
class Charge
  def initialize(rule)
    # 料金の計算規則
    # 例：{ 10 => 123, 20 => 456, ... }
    @rule = rule
  end

  # 料金の計算用抽象メソッド
  # _conditions：ユーザー側の条件（hash）
  # 例：{ amp: 10, kwh: 100 }（契約アンペア数[A]が10，使用量[kWh]が100の場合）
  def calculate(_conditions)
    raise 'Called abstract method: calculate'
  end
end
