require 'spec_helper'

describe 'DemandCharge' do

  describe 'initialized' do

    it '入力データの取り出し ampere = 0' do
      demand_charge = DemandCharge.new(0)
      expect(demand_charge.ampere).to eq(0)
    end

    it '入力データの取り出し ampere = 31' do
      demand_charge = DemandCharge.new(31)
      expect(demand_charge.ampere).to eq(31)
    end

    it '入力データの取り出し ampere = 100' do
      demand_charge = DemandCharge.new(100)
      expect(demand_charge.ampere).to eq(100)
    end
  end

  describe 'tokyo_demand' do

    context 'アンペアの値が価格表にある時' do
      it '正しい価格の表示 ampere = 10' do
        demand_charge = DemandCharge.new(10)
        expect(demand_charge.tokyo_demand).to eq(286)
      end

      it '正しい価格の表示 ampere = 15' do
        demand_charge = DemandCharge.new(15)
        expect(demand_charge.tokyo_demand).to eq(429)
      end

      it '正しい価格の表示 ampere = 20' do
        demand_charge = DemandCharge.new(20)
        expect(demand_charge.tokyo_demand).to eq(572)
      end

      it '正しい価格の表示 ampere = 30' do
        demand_charge = DemandCharge.new(30)
        expect(demand_charge.tokyo_demand).to eq(858)
      end

      it '正しい価格の表示 ampere = 40' do
        demand_charge = DemandCharge.new(40)
        expect(demand_charge.tokyo_demand).to eq(1144)
      end

      it '正しい価格の表示 ampere = 50' do
        demand_charge = DemandCharge.new(50)
        expect(demand_charge.tokyo_demand).to eq(1430)
      end

      it '正しい価格の表示 ampere = 60' do
        demand_charge = DemandCharge.new(60)
        expect(demand_charge.tokyo_demand).to eq(1716)
      end


    end

    context 'アンペアの値が価格表にない時' do
      it 'nilの表示 ampere = 0' do
        demand_charge = DemandCharge.new(0)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end

      it 'nilの表示 ampere = 25' do
        demand_charge = DemandCharge.new(25)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end

      it 'nilの表示 ampere = 35' do
        demand_charge = DemandCharge.new(35)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end

      it 'nilの表示 ampere = 45' do
        demand_charge = DemandCharge.new(45)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end

      it 'nilの表示 ampere = 55' do
        demand_charge = DemandCharge.new(55)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end

      it 'nilの表示 ampere = 70' do
        demand_charge = DemandCharge.new(70)
        expect(demand_charge.tokyo_demand).to eq(nil)
      end
    end
  end

  describe 'looop_demand' do
    it "正しい価格の表示 ampere = 0" do
      demand_charge = DemandCharge.new(0)
      expect(demand_charge.looop_demand).to eq(0)
    end

    it "正しい価格の表示 ampere = 10" do
      demand_charge = DemandCharge.new(10)
      expect(demand_charge.looop_demand).to eq(0)
    end

    it "正しい価格の表示 ampere = 30" do
      demand_charge = DemandCharge.new(30)
      expect(demand_charge.looop_demand).to eq(0)
    end

    it "正しい価格の表示 ampere = 60" do
      demand_charge = DemandCharge.new(60)
      expect(demand_charge.looop_demand).to eq(0)
    end

    it "正しい価格の表示 ampere = 70" do
      demand_charge = DemandCharge.new(70)
      expect(demand_charge.looop_demand).to eq(0)
    end
  end

  describe 'tokyogas_demand' do
    context 'アンペアの値が価格表にある時' do
      it "正しい価格の表示 ampere = 30" do
        demand_charge = DemandCharge.new(30)
        expect(demand_charge.tokyogas_demand).to eq(858)
      end

      it "正しい価格の表示 ampere = 40" do
        demand_charge = DemandCharge.new(40)
        expect(demand_charge.tokyogas_demand).to eq(1144)
      end

      it "正しい価格の表示 ampere = 50" do
        demand_charge = DemandCharge.new(50)
        expect(demand_charge.tokyogas_demand).to eq(1430)
      end

      it "正しい価格の表示 ampere = 60" do
        demand_charge = DemandCharge.new(60)
        expect(demand_charge.tokyogas_demand).to eq(1716)
      end
    end

    context 'アンペアの値が価格表にない時' do
      it "nilの表示 ampere = 0" do
        demand_charge = DemandCharge.new(0)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 10" do
        demand_charge = DemandCharge.new(10)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 20" do
        demand_charge = DemandCharge.new(20)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 31" do
        demand_charge = DemandCharge.new(31)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 42" do
        demand_charge = DemandCharge.new(42)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 56" do
        demand_charge = DemandCharge.new(56)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end

      it "nilの表示 ampere = 70" do
        demand_charge = DemandCharge.new(70)
        expect(demand_charge.tokyogas_demand).to eq(nil)
      end
    end
  end

  describe 'choose_plan' do
    it '選択したプランの料金の表示 従量電灯B ampere = 10' do
      demand_charge = DemandCharge.new(10)
      plan_name = '従量電灯B'
      expect(demand_charge.choose_plan(plan_name)).to eq(286)
    end

    it '選択したプランの料金の表示 従量電灯B ampere = 30' do
      demand_charge = DemandCharge.new(30)
      plan_name = '従量電灯B'
      expect(demand_charge.choose_plan(plan_name)).to eq(858)
    end

    it '選択したプランの料金の表示 おうちプラン ampere = 10' do
      demand_charge = DemandCharge.new(10)
      plan_name = 'おうちプラン'
      expect(demand_charge.choose_plan(plan_name)).to eq(0)
    end

    it '選択したプランの料金の表示 おうちプラン ampere = 30' do
      demand_charge = DemandCharge.new(30)
      plan_name = 'おうちプラン'
      expect(demand_charge.choose_plan(plan_name)).to eq(0)
    end

    it '選択したプランの料金の表示 ずっとも電気1 ampere = 10' do
      demand_charge = DemandCharge.new(10)
      plan_name = 'ずっとも電気1'
      expect(demand_charge.choose_plan(plan_name)).to eq(nil)
    end

    it '選択したプランの料金の表示 ずっとも電気1 ampere = 30' do
      demand_charge = DemandCharge.new(30)
      plan_name = 'ずっとも電気1'
      expect(demand_charge.choose_plan(plan_name)).to eq(858)
    end


  end
end
