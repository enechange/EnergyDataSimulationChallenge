# frozen_string_literal: true

require_relative 'charge'

# 従量料金クラス（料金クラスを継承）
class UsageCharge < Charge
  def calculate(conditions)
    # 使用量
    kwh = conditions[:kwh]
    result = 0
    # 使用量が正でなかった場合，0を返す
    return result if kwh <= 0

    # ソートされた，料金の計算規則の全閾値（0, Infinityを含む）と使用量から成る配列
    # 例：[0, 120, 240, 300, Infinity]（全閾値が，0, 120, 300, Infinity，使用量が240の場合）
    kwhs = @rule.keys.push(0, kwh).sort
    kwhs.length.times do |i|
      next if i.zero?

      if kwhs[i] == kwh
        # i番目の要素が使用量と一致した場合，その時点での計算結果に，
        # 使用量とi-1番目の要素（閾値）の差に，i+1番目の要素（閾値）に対応する料金を乗算した結果を足し込む
        # 例：上の例で考えた場合，足し込まれる値は，(240 - 120) * (300に対応する料金)となる
        result += (kwh - kwhs[i - 1]) * @rule[kwhs[i + 1]]
        break
      else
        # その時点での計算結果に，i番目の要素（閾値）とi-1番目の要素（閾値）の差に，i番目の要素（閾値）に対応する料金を乗算した結果を足し込む
        result += (kwhs[i] - kwhs[i - 1]) * @rule[kwhs[i]]
      end
    end
    result
  end
end
