require 'csv'
require_relative 'plan'

class CSVPlan
  attr_reader :provider_name, :plan_name, :basic_charge_list, :usage_charge_list

  def initialize(provider_name, plan_name, basic_charge_list, usage_charge_list)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge_list = basic_charge_list
    @usage_charge_list = usage_charge_list
  end

  def convert_to_plan
    Plan.new(
      provider_name,
      plan_name,
      basic_charge_list,
      usage_charge_list
    )
  end

  class << self
    def create_list_from_csv
      plans = []
      plans_dir = Dir.glob('../csv/*', base: __dir__)
      plans_dir.each do |plan|
        info = CSV.table(File.expand_path("./#{plan}/info.csv", __dir__))
        plans << CSVPlan.new(info[:provider_name][0],
                             info[:plan_name][0],
                             CSV.read(File.expand_path("./#{plan}/basic_charge.csv", __dir__), headers: true).map(&:to_hash),
                             CSV.read(File.expand_path("./#{plan}/usage_charge.csv", __dir__), headers: true).map(&:to_hash)
        )
      end
      plans
    end
  end
end
