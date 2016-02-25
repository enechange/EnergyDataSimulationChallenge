module Plan
  class BasicPlan < PlanBase
    def initialize(plan)
      @day_time = plan["Day time"]
    end

    def calc(usage)
      puts "basic plan! #{usage}"
    end
  end
end
