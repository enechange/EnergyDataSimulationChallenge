require 'spec_helper'

describe 'EnergyCharge' do
  describe 'initialize' do
    it '入力データの取り出し usage = 0' do
      energy_charge = EnergyCharge.new(0)
      expect(energy_charge.usage).to eq(0)
    end

    it '入力データの取り出し usage = 33' do
      energy_charge = EnergyCharge.new(33)
      expect(energy_charge.usage).to eq(33)
    end

    it '入力データの取り出し usage = 321' do
      energy_charge = EnergyCharge.new(321)
      expect(energy_charge.usage).to eq(321)
    end
  end

  describe 'tokyo_energy' do
    it '正確な価格の表示 usage = 0' do
      energy_charge = EnergyCharge.new(0)
      expect(energy_charge.tokyo_energy).to eq(0)
    end

    it '正確な価格の表示 usage = 50' do
      energy_charge = EnergyCharge.new(50)
      expect(energy_charge.tokyo_energy).to eq(994)
    end

    it '正確な価格の表示 usage = 119' do
      energy_charge = EnergyCharge.new(119)
      expect(energy_charge.tokyo_energy).to eq(2365)
    end

    it '正確な価格の表示 usage = 120' do
      energy_charge = EnergyCharge.new(120)
      expect(energy_charge.tokyo_energy).to eq(2385)
    end

    it '正確な価格の表示 usage = 121' do
      energy_charge = EnergyCharge.new(121)
      expect(energy_charge.tokyo_energy).to eq(2412)
    end

    it '正確な価格の表示 usage = 210' do
      energy_charge = EnergyCharge.new(210)
      expect(energy_charge.tokyo_energy).to eq(4768)
    end

    it '正確な価格の表示 usage = 299' do
      energy_charge = EnergyCharge.new(299)
      expect(energy_charge.tokyo_energy).to eq(7125)
    end

    it '正確な価格の表示 usage = 300' do
      energy_charge = EnergyCharge.new(300)
      expect(energy_charge.tokyo_energy).to eq(7152)
    end

    it '正確の価格の表示 usage = 301' do
      energy_charge = EnergyCharge.new(301)
      expect(energy_charge.tokyo_energy).to eq(7182)
    end
  end

  describe 'looop_energy' do
    it "正確な価格の表示 usage = 0" do
      energy_charge = EnergyCharge.new(0)
      expect(energy_charge.looop_energy).to eq(0)
    end

    it "正確な価格の表示 usage = 50" do
      energy_charge = EnergyCharge.new(50)
      expect(energy_charge.looop_energy).to eq(1320)
    end

    it "正確な価格の表示 usage = 111" do
      energy_charge = EnergyCharge.new(111)
      expect(energy_charge.looop_energy).to eq(2930)
    end

    it "正確な価格の表示 usage = 201" do
      energy_charge = EnergyCharge.new(201)
      expect(energy_charge.looop_energy).to eq(5306)
    end

    it "正確な価格の表示 usage = 300" do
      energy_charge = EnergyCharge.new(300)
      expect(energy_charge.looop_energy).to eq(7920)
    end

    it "正確な価格の表示 usage = 432" do
      energy_charge = EnergyCharge.new(432)
      expect(energy_charge.looop_energy).to eq(11404)
    end
  end

  describe 'tokyogas_energy' do
    it "正しい価格の表示 usage = 0" do
      energy_charge = EnergyCharge.new(0)
      expect(energy_charge.tokyogas_energy).to eq(0)
    end

    it "正しい価格の表示 usage = 70" do
      energy_charge = EnergyCharge.new(70)
      expect(energy_charge.tokyogas_energy).to eq(1656)
    end

    it "正しい価格の表示 usage = 139" do
      energy_charge = EnergyCharge.new(139)
      expect(energy_charge.tokyogas_energy).to eq(3290)
    end

    it "正しい価格の表示 usage = 140" do
      energy_charge = EnergyCharge.new(140)
      expect(energy_charge.tokyogas_energy).to eq(3313)
    end

    it "正しい価格の表示 usage = 141" do
      energy_charge = EnergyCharge.new(141)
      expect(energy_charge.tokyogas_energy).to eq(3337)
    end

    it "正しい価格の表示 usage = 349" do
      energy_charge = EnergyCharge.new(349)
      expect(energy_charge.tokyogas_energy).to eq(8304)
    end

    it "正しい価格の表示 usage = 350" do
      energy_charge = EnergyCharge.new(350)
      expect(energy_charge.tokyogas_energy).to eq(8328)
    end

    it "正しい価格の表示 usage = 351" do
      energy_charge = EnergyCharge.new(351)
      expect(energy_charge.tokyogas_energy).to eq(8355)
    end

    it "正しい価格の表示 usage = 400" do
      energy_charge = EnergyCharge.new(400)
      expect(energy_charge.tokyogas_energy).to eq(9649)
    end

  end

  describe 'choose_plan' do

    context '従量電灯B' do
      it '選択したプランの料金の表示 usage = 120' do
        energy_charge = EnergyCharge.new(120)
        plan_name = '従量電灯B'
        expect(energy_charge.choose_plan(plan_name)).to eq(2385)
      end

      it '選択したプランの料金の表示 usage = 140' do
        energy_charge = EnergyCharge.new(140)
        plan_name = '従量電灯B'
        expect(energy_charge.choose_plan(plan_name)).to eq(2915)
      end

      it '選択したプランの料金の表示 usage = 300' do
        energy_charge = EnergyCharge.new(300)
        plan_name = '従量電灯B'
        expect(energy_charge.choose_plan(plan_name)).to eq(7152)
      end

      it '選択したプランの料金の表示 usage = 350' do
        energy_charge = EnergyCharge.new(350)
        plan_name = '従量電灯B'
        expect(energy_charge.choose_plan(plan_name)).to eq(8680)
      end
    end

    context 'おうちプラン' do
      it '選択したプランの料金の表示 usage = 120' do
        energy_charge = EnergyCharge.new(120)
        plan_name = 'おうちプラン'
        expect(energy_charge.choose_plan(plan_name)).to eq(3168)
      end

      it '選択したプランの料金の表示 usage = 140' do
        energy_charge = EnergyCharge.new(140)
        plan_name = 'おうちプラン'
        expect(energy_charge.choose_plan(plan_name)).to eq(3696)
      end

      it '選択したプランの料金の表示 usage = 300' do
        energy_charge = EnergyCharge.new(300)
        plan_name = 'おうちプラン'
        expect(energy_charge.choose_plan(plan_name)).to eq(7920)
      end

      it '選択したプランの料金の表示 usage = 350' do
        energy_charge = EnergyCharge.new(350)
        plan_name = 'おうちプラン'
        expect(energy_charge.choose_plan(plan_name)).to eq(9240)
      end
    end

    context 'ずっとも電気1' do
      it '選択したプランの料金の表示 usage = 120' do
        energy_charge = EnergyCharge.new(120)
        plan_name = 'ずっとも電気1'
        expect(energy_charge.choose_plan(plan_name)).to eq(2840)
      end

      it '選択したプランの料金の表示 usage = 140' do
        energy_charge = EnergyCharge.new(140)
        plan_name = 'ずっとも電気1'
        expect(energy_charge.choose_plan(plan_name)).to eq(3313)
      end

      it '選択したプランの料金の表示 usage = 300' do
        energy_charge = EnergyCharge.new(300)
        plan_name = 'ずっとも電気1'
        expect(energy_charge.choose_plan(plan_name)).to eq(7134)
      end

      it '選択したプランの料金の表示 usage = 351' do
        energy_charge = EnergyCharge.new(351)
        plan_name = 'ずっとも電気1'
        expect(energy_charge.choose_plan(plan_name)).to eq(8355)
      end
    end


  end


end
