require "observer"

module Plans
  class Loader
    attr_reader :plans

    include Observable

    PLANS_DATA_PATH = Rails.root.join("data", "plans.json")
    PLAN_NAMES = [
      "Meter-Rate Lighting B",
      "Yoru Toku Plan",
    ]

    alias_method :add_plan, :add_observer

    def initialize
      @plans = []
    end

    def self.load
      instance = self.new
      instance.load
      instance
    end

    def load
      PLAN_NAMES.each do |plan_name|
        plan = ::Plan::Loader.load(plan_data[plan_name])
        plan.name = plan_name
        add_plan(plan, :calc)
        @plans << plan
      end
    end

    def usage=(usage_data)
      changed
      notify_observers(usage_data)
    end

    def as_json(options={})
      @plans
    end

    private

    def plan_data
      JSON.parse(File.read(PLANS_DATA_PATH))
    end
  end
end
