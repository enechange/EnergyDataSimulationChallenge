module Plan
  class Loader
    attr_reader :plan

    def initialize(plan)
      @plan = plan
    end

    def self.load(plan)
      self.new(plan).load
    end

    def load
      if plan["Night time"]
        NightPlan.new(plan)
      else
        BasicPlan.new(plan)
      end
    end
  end
end
