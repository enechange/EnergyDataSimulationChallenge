# frozen_string_literal: true

require_relative 'charge'

# 基本料金クラス（料金クラスを継承）
class BasicCharge < Charge
  # 料金の計算用メソッド
  # 引数：契約アンペア数（整数）
  def calculate(amp)
    # 引数が認められていない契約アンペア数であった場合，NaNを返す
    return Float::NAN unless @rule.keys.include?(amp)

    # 契約アンペア数に対応する料金を返す
    @rule[amp]
  end
end
