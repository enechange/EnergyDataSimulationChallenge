module Loader
  class PlanLoader
    attr_reader :plan

    def initialize(plan)
      @plan = plan
    end

    def self.load(plan)
      self.new(plan).load
    end

    def load
      if plan["Night time"]
        ::Plan::NightPlan.new(plan)
      else
        ::Plan::BasicPlan.new(plan)
      end
    end
  end
end
