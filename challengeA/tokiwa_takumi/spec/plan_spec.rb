require "spec_helper"

RSpec.describe Plan do
  let!(:plan) { CSVPlan.create_list_from_csv.map(&:convert_to_plan) }

  describe "東京ガスずっともでんき１" do
    let!(:tokyo_gas) { plan.find{ |plan| plan.provider_name == "東京ガス" }}

    describe "基本料金の算出が正しいこと" do
      it "対応アンペアが存在する" do
        expect(tokyo_gas.basic_charge(30)).to eq 858
      end

      it "対応アンペアが存在しない" do
        expect(tokyo_gas.basic_charge(100)).to eq nil
      end
    end

    describe "従量課金料金の算出が正しいこと" do
      it "1つの区分で収まる使用量で算出する" do
        expect(tokyo_gas.usage_charge(100)).to eq (23.67 * 100)
      end

      it "2つ以上の区分にまたがる使用量で算出する" do
        expect_value = (23.67 * 140) + (23.88 * 160)
        expect(tokyo_gas.usage_charge(300)).to eq expect_value
      end

      it "一番上の区分まで使用した算出をする" do
        expect_value = (23.67 * 140) + (23.88 * 210) + (26.41 * 50)
        expect(tokyo_gas.usage_charge(400)).to eq expect_value
      end
    end
  end

  describe "東京エナジーパートナー従量電灯B" do
    let!(:tepco) { plan.find{ |plan| plan.provider_name == "東京電力エナジーパートナー" }}

    describe "基本料金の算出が正しいこと" do
      it "対応アンペアが存在する" do
        expect(tepco.basic_charge(40)).to eq 1144
      end

      it "対応アンペアが存在しない" do
        expect(tepco.basic_charge(100)).to eq nil
      end
    end

    describe "従量課金料金の算出が正しいこと" do
      it "1つの区分で収まる使用量で算出する" do
        expect(tepco.usage_charge(100)).to eq (19.88 * 100)
      end

      it "2つ以上の区分にまたがる使用量で算出する" do
        expect_value = (19.88 * 120) + (26.48 * 180)
        expect(tepco.usage_charge(300)).to eq expect_value
      end

      it "一番上の区分まで使用した算出をする" do
        expect_value = (19.88 * 120) + (26.48 * 180) + (30.57 * 100)
        expect(tepco.usage_charge(400)).to eq expect_value
      end
    end
  end

  describe "Loop電気おうちプラン" do
    let!(:loop) { plan.find{ |plan| plan.provider_name == "Looopでんき" }}

    describe "基本料金の算出が正しいこと" do
      it "対応アンペアが存在する" do
        expect(loop.basic_charge(40)).to eq 0
      end

      it "対応アンペアが存在しない" do
        expect(loop.basic_charge(100)).to eq nil
      end
    end

    it "基本料金の算出が正しいこと" do
      expect(loop.basic_charge(40)).to eq 0
    end

    describe "従量課金料金の算出が正しいこと(区分が1つのみ)" do
      it "1つの区分だけで算出されること" do
        expect(loop.usage_charge(500)).to eq (26.40 * 500)
      end
    end
  end

  describe "JXTGでんき従量電灯Bたっぷりプラン" do
    let!(:jxtg) { plan.find{ |plan| plan.provider_name == "JXTGでんき" }}

    describe "基本料金の算出が正しいこと" do
      it "対応アンペアが存在する" do
        expect(jxtg.basic_charge(50)).to eq 1430
      end

      it "対応アンペアが存在しない" do
        expect(jxtg.basic_charge(100)).to eq nil
      end
    end

    describe "従量課金料金の算出が正しいこと" do
      it "1つの区分で収まる使用量で算出する" do
        expect(jxtg.usage_charge(100)).to eq (19.88 * 100)
      end

      it "2つ以上の区分にまたがる使用量で算出する" do
        expect_value = (19.88 * 120) + (26.48 * 180)
        expect(jxtg.usage_charge(300)).to eq expect_value
      end

      it "一番上の区分まで使用した算出をする" do
        expect_value = (19.88 * 120) + (26.48 * 180) + (25.08 * 300) + (26.15 * 50)
        expect(jxtg.usage_charge(650)).to eq expect_value
      end
    end
  end
end
