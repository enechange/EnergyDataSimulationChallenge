module Plan
  class PlanBase
    attr_accessor :name
    attr_reader :result

    def calc
      raise NotImplementedError
    end

    def to_s
      name
    end
  end
end
