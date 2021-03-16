require 'csv'

class Plan
  attr_reader :provider_name, :plan_name, :basic_charge_list, :usage_charge_list, :min_charge

  def initialize(provider_name, plan_name, basic_charge_list, usage_charge_list, min_charge)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge_list = basic_charge_list
    @usage_charge_list = usage_charge_list
    @min_charge = min_charge
  end

  companies = Dir.glob('csv/*')
  ALLPLANS = []

  companies.each do |d|
    info = CSV.table(File.expand_path("./#{d}/info.csv"))
    ALLPLANS << Plan.new(info[:provider_name][0],
                         info[:plan_name][0],
                         CSV.table(File.expand_path("./#{d}/basic_charge.csv")),
                         CSV.table(File.expand_path("./#{d}/usage_charge.csv")),
                         info[:min_charge][0])
  end
end
