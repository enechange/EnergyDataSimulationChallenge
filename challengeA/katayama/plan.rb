class Plan
  attr_accessor :name, :provider_name, :supported_amp, :base, :as_pay, :is_supported, :min_charge

  # 電気料金の計算ロジックにおいて今回適用外としているもの
  # ・燃料費調整額及び再生可能エネルギー賦課金
  # ・「東京ガス ずっとも電気１」の「ガス・電気セット割（定額A）」- [基本料金から275円(税込み)割引]

  # 従量料金表において電気使用量の上限が存在しない場合の値
  AS_PAY_CHARGE_RANGE_MAX = 9999

  def initialize(args)
    # プラン名
    @name = args["name"]
    # 会社名
    @provider_name = args["provider_name"]
    # 対応アンペア一覧
    @supported_amp = args["supported_amp"]
    # 基本料金
    @base = args["base"]
    # 従量料金
    @as_pay = args["as_pay"]
    # アンペア対応可否
    @is_supported = true
    # 月額料金最低額
    @min_charge = args["min_charge"]
  end

  # 電気料金を計算する
  def calc_total_charge(amp, kwh)

      # 基本料金の計算
      base_charge = calc_base_charge(amp, kwh)

      # 従量料金の計算
      as_pay_charge = calc_as_pay_charge(kwh)
      
      # 電気料金 = 基本料金 + 従量料金(少数切り捨て)
      total_charge = (base_charge + as_pay_charge).floor
      
      # 電気料金が月額最低額以下の場合、月額最低額で電気料金を計上する
      # (現時点で東京電力エナジーパートナー 従量電灯Bのみ確認)
      if !self.min_charge.nil? && self.min_charge > total_charge
        total_charge = self.min_charge.floor
      end

      return total_charge
  end

  private 

  # 基本料金の算出を実行する
  def calc_base_charge(input_amp, kwh)
    base_charge = 0

    # 入力されたアンペアがプラン対象かどうか判定
    if self.supported_amp.include?(input_amp)

      # 入力されたアンペアが対応可の場合、入力された契約アンペア数に対応する基本料金を算出する
      target_amp = self.base.find {|b| b["amp"] == input_amp}
      base_charge = target_amp["charge"]

      # 電気使用量が0kWhの場合、電気料金のうち基本料金が半額になる
      if kwh == 0  
        base_charge = base_charge/2
      end

      return base_charge
    else

      # 入力されたアンペアが対応外の場合
      self.is_supported = false
      return base_charge
    end
  end

  # 従量料金の算出を実行する
  # 従量料金 = 従量料金の単価 × 電気使用量(kWh)
  def calc_as_pay_charge(input_amount)
    range_array = self.as_pay
    as_pay_sum = 0
    
    # 電気使用量に対応した従量料金の料金帯を取得
    max_range = range_array.find {|a| is_range?(input_amount, a)}
    index = range_array.index(max_range)
    range_array.each_with_index do |range, idx|

      # 電気使用量が従量料金の料金帯における端数の場合
      if idx == index && is_range?(input_amount, range)
        as_pay_sum += max_range["per_charge"]* (input_amount - max_range["from"])
        break
      end
      as_pay_sum += range["per_charge"]*(range["to"] - range["from"])
    end
    return as_pay_sum
  end

  # 従量料金の料金帯に含まれるか否か
  def is_range?(value, oppo)
    return oppo["from"] <= value && value <= oppo["to"]
  end

end