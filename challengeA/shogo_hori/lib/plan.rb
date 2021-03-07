require 'csv'

class Plan
  attr_reader :provider_name, :plan_name, :basic_charge, :usage_charge

  def initialize(provider_name, plan_name, basic_charge, usage_charge)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge = basic_charge
    @usage_charge = usage_charge
  end
end

companies = Dir.glob("csv/*")
plans = []

companies.each do |u|
  info = CSV.read(File.expand_path("./#{u}/info.csv"))
  plans << Plan.new(info.find { |name| name[0] = 'provider_name' }[1],
                   info.find { |name| name[0] = 'plan_name' }[1],
                   CSV.read(File.expand_path("./#{u}/basicCharge.csv")),
                   CSV.read(File.expand_path("./#{u}/usageCharge.csv")))
end
