require "spec_helper"

RSpec.describe Simulator do
  describe "simulatorの結果をが期待どおりであること" do
    let!(:simulator) { Simulator.new(40, 300) }

    it "simulator" do
      expect(simulator.simulate.count).to eq 4
      expect(simulator.simulate).to match_array [
        {
          "provider_name": "東京ガス",
          "plan_name": "ずっともでんき１",
          "price": 1144 + (23.67 * 140) + (23.88 * 160)
        },
        {
          "provider_name": "JXTGでんき",
          "plan_name": "従量電灯Bたっぷりプラン",
          "price": 1144 + (19.88 * 120) + (26.48 * 180)
        },
        {
          "provider_name": "Looopでんき",
          "plan_name": "おうちプラン",
          "price": (26.40 * 300)
        },
        {
          "provider_name": "東京電力エナジーパートナー",
          "plan_name": "従量電灯B",
          "price": 1144 + (19.88 * 120) + (26.48 * 180)
        }
      ]
    end
  end
end
