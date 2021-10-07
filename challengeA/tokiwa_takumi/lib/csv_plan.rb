require 'csv'

class CSVPlan
  attr_reader :provider_name, :plan_name, :basic_charge_list, :usage_charge_list

  def initialize(provider_name, plan_name, basic_charge_list, usage_charge_list)
    @provider_name = provider_name
    @plan_name = plan_name
    @basic_charge_list = basic_charge_list
    @usage_charge_list = usage_charge_list
  end

  class << self
    def create_list_from_csv
      plans = []

      plans_dir = Dir.glob('../csv/*')

      plans_dir.each do |plan|
        info = CSV.read(File.expand_path("./#{plan}/info.csv"), headers: true)
        plans << CSVPlan.new(info[:provider_name][0],
                             info[:plan_name][0],
                             CSV.read(File.expand_path("./#{plan}/basic_charge.csv"), headers: true).map(&:to_hash),
                             CSV.read(File.expand_path("./#{plan}/usage_charge.csv"), headers: true).map(&:to_hash)
        )
      end
      plans
    end
  end
end
