class Plan
  attr_reader :provider_name, :plan_name, :basic_charge_list, :usage_charge_list

  def initialize(provider_name, plan_name, basic_charge_list, usage_charge_list)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge_list = basic_charge_list
    @usage_charge_list = usage_charge_list
  end

  def simulate_charge(ampere, monthly_amount_kwh)
    basic_charge = basic_charge(ampere)
    return if basic_charge.nil? ## 対応するアンペアなし

    price = basic_charge + usage_charge(monthly_amount_kwh)
    {
      "provider_name": @provider_name,
      "plan_name": @plan_name,
      "price": price
    }
  end

  private

  def basic_charge(ampere)
    basic_charge_plan = basic_charge_list.find{ |c| c["ampere"].to_i == ampere }
    basic_charge_plan["basic_charge"].to_i unless basic_charge_plan.nil?
  end

  def usage_charge(monthly_amount_kwh)
    charge = 0
    usage_charge_list.each do |usage_charge|
      gt = usage_charge["greater_than"].to_i
      lt = usage_charge["less_than"].to_i
      unit_charge = usage_charge["unit_charge"].to_f
      if lt.zero? && gt < monthly_amount_kwh # 最大区分
        charge += (monthly_amount_kwh - gt) * unit_charge
      elsif lt <= monthly_amount_kwh && !lt.zero? # 超過する区分
        charge += (lt - gt) * unit_charge
      elsif gt < monthly_amount_kwh && monthly_amount_kwh < lt # 超過しない区分
        charge += (monthly_amount_kwh - gt) * unit_charge
      end
    end
    charge
  end
end
