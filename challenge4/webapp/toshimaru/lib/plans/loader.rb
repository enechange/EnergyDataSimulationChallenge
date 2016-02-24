module Plans
  class Loader
    PLANS_DATA_PATH = Rails.root.join("data", "plans.json")
    PLANS_DATA = JSON.parse(File.read(PLANS_DATA_PATH))
    PLAN_B = "Meter-Rate Lighting B"
    PLAN_YORU_TOKU = "Yoru Toku Plan"

    def initialize
      @plans = []
    end

    def self.load
      self.new.load
    end

    def load
      @plans << ::Plan::Loader.load(PLANS_DATA[PLAN_B])
      @plans << ::Plan::Loader.load(PLANS_DATA[PLAN_YORU_TOKU])
    end
  end
end
