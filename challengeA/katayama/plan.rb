class Plan
  attr_accessor :name, :provider_name, :support_amp, :base, :as_pay

  # 契約アンペア数１Aあたりの基本料金単価
  BASIC_CHARGE_UNIT_PRICE = 28.6

  #入力されたkWhが上限なしの場合
  AS_PAY_CHARGE_RANGE_MAX = 9999

  def initialize(args)
    @name = args["name"]
    @provider_name = args["provider_name"]
    @support_amp = args["support_amp"]
    @base= args["base"]
    @as_pay = args["as_pay"]
  end

  # 基本料金の算出を実行する
  def calc_base_charge(input_amp)

    # 入力された契約アンペア数に対応する基本料金を算出する
    target_amp = self.base.find {|b| b["amp"] == input_amp}
    return target_amp["charge"]
  end

  # 従量料金の算出を実行する
  def calc_as_pay_charge(input_amount)

    # 入力された電気使用量に対応する従量料金の単価を算出する
    target_range = self.as_pay.find {|a| (a["to"] == AS_PAY_CHARGE_RANGE_MAX ) ? true : (a["from"] <= input_amount &&  input_amount <= a["to"])}

    # 従量料金 = 従量料金の単価 × 電気使用量(kWh)
    return target_range["per_charge"]*input_amount
  end
end