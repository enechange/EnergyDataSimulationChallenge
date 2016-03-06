module Plan
  class PlanBase
    attr_accessor :name
    attr_reader :result

    def calc
      raise NotImplementedError
    end

    def as_json(options={})
      {
        name: name,
        price: result.to_i,
      }
    end
  end
end
