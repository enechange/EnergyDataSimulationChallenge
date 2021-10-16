# frozen_string_literal: true

require_relative 'charge'

# 基本料金クラス（料金クラスを継承）
class BasicCharge < Charge
  def calculate(conditions)
    # 契約アンペア数
    amp = conditions[:amp]
    # 認められていない契約アンペア数であった場合，NaNを返す
    return Float::NAN unless @rule.keys.include?(amp)
    # 使用量が0の場合は，契約アンペア数に対応する料金の半額を返す
    return @rule[amp] / 2 if conditions[:kwh] <= 0

    # 契約アンペア数に対応する料金を返す
    @rule[amp]
  end
end
