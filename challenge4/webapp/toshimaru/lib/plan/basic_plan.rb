module Plan
  class BasicPlan < PlanBase
    def initialize(plan)
      @day_time = plan["Day time"]
    end

    def calc
    end
  end
end
