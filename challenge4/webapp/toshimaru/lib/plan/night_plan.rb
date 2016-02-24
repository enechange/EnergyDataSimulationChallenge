module Plan
  class NightPlan < PlanBase
    def initialize(plan)
      @day_time = plan["Day time"]
      @night_time = plan["Night time"]
      @night_time_range = plan["Night time range"]
    end

    def calc
    end
  end
end
