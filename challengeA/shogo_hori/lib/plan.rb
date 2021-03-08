
require 'csv'

class Plan
  attr_reader :provider_name, :plan_name, :basic_charge_list, :usage_charge_list

  def initialize(provider_name, plan_name, basic_charge_list, usage_charge_list)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge_list = basic_charge_list
    @usage_charge_list = usage_charge_list
  end
end

companies = Dir.glob('csv/*')
plans = []

companies.each do |d|
  info = CSV.table(File.expand_path("./#{d}/info.csv"))
  plans << Plan.new(info[:provider_name][0],
                  info[:plan_name][0],
                  CSV.read(File.expand_path("./#{d}/basicCharge.csv")),
                  CSV.read(File.expand_path("./#{d}/usageCharge.csv")))
end
