# frozen_string_literal: true

# 料金クラス
class Charge
  def initialize(rule)
    # 料金の計算規則
    # 例：{ 10 => 123, 20 => 456, ... }
    @rule = rule
  end
end
