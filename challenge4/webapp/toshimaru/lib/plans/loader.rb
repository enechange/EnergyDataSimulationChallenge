require "observer"

module Plans
  class Loader
    include Observable

    PLANS_DATA_PATH = Rails.root.join("data", "plans.json")
    PLAN_B = "Meter-Rate Lighting B"
    PLAN_YORU_TOKU = "Yoru Toku Plan"

    alias_method :add_plan, :add_observer

    def initialize
    end

    def self.load
      instance = self.new
      instance.load
      instance
    end

    def load
      add_plan(::Plan::Loader.load(plan_data[PLAN_B]), :calc)
      add_plan(::Plan::Loader.load(plan_data[PLAN_YORU_TOKU]), :calc)
    end

    def usage_data=(usage_data)
      changed
      notify_observers(usage_data)
    end

    private

    def plan_data
      JSON.parse(File.read(PLANS_DATA_PATH))
    end
  end
end
