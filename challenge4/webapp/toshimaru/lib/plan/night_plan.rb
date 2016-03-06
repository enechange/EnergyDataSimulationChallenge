module Plan
  class NightPlan < PlanBase
    def initialize(plan)
      @day_time = plan["Day time"]
      @night_time = plan["Night time"]
      @night_time_range = plan["Night time range"]
      result = 0
    end

    def calc(usage)
      puts "night plan! #{usage}"
    end
  end
end
