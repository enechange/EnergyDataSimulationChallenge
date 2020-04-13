require "spec_helper"
require "simulator"

describe Simulator do
  let(:random_amp){[10, 15, 20, 30, 40, 50, 60].at(rand(6))}
  let(:random_amp2){[30, 40, 50, 60].at(rand(3))}
  let(:random_amp3){[10, 15, 20].at(rand(2))}
  let(:random_usage){rand(0..1000)}
  let(:simulator){Simulator.new(random_amp, random_usage)}
  EP_planB_SET = {rate: {0 => 19.88, 120 => 26.48, 300 => 30.57}, basicChargeRate: 28.6 }
  TG_ZUTTOMO_SET = {rate: {0 => 23.67, 140 => 23.88, 350 => 26.41}, basicChargeRate: 28.6 }


  describe "self#EP_planB_SET" do
    subject { Simulator.EP_planB_SET }
    it { is_expected.to eq EP_planB_SET }
  end

  describe "self#TG_ZUTTOMO_SET" do
    subject { Simulator.TG_ZUTTOMO_SET }
    it { is_expected.to eq TG_ZUTTOMO_SET }
  end

  describe "self#acceptableAmperes" do
    subject { Simulator.acceptableAmperes }
    it { is_expected.to eq [10, 15, 20, 30, 40, 50, 60] }
  end

  describe '#attr_reader' do
    it "show the ampere initialized" do
      expect(simulator.amp).to eq random_amp
    end

    it "show the usage initialized" do
      expect(simulator.usage).to eq random_usage
    end
  end

  describe 'Loope おうちプラン' do
    it "calculates charge of Looop's homePlan" do
      simulator = Simulator.new(random_amp, random_usage)
      expected_charge =  26.40 * random_usage
      expect(simulator.looop_homePlan_bill).to eq expected_charge.floor
    end
  end

  describe '#ep_planB' do
    it " 東京電力従量電灯B 10~60A, 第二段階を超えない使用量" do
      random_usage = rand(0..EP_planB_SET[:rate].keys[1])
      simulator = Simulator.new(random_amp, random_usage)
      expected_charge =  EP_planB_SET[:basicChargeRate] * random_amp + EP_planB_SET[:rate].values[0] * random_usage
      expect(simulator.ep_planB_bill).to eq expected_charge.floor
    end

    it "東京電力従量電灯B 10~60A, 第三段階を超えない使用量" do
      random_usage = rand((EP_planB_SET[:rate].keys[1] + 1)..EP_planB_SET[:rate].keys[2])
      simulator = Simulator.new(random_amp, random_usage)
      expected_charge =  EP_planB_SET[:basicChargeRate] * random_amp + EP_planB_SET[:rate].values[0] * EP_planB_SET[:rate].keys[1] + EP_planB_SET[:rate].values[1] * (random_usage - EP_planB_SET[:rate].keys[1])
      expect(simulator.ep_planB_bill).to eq expected_charge.floor
    end

    it "東京電力従量電灯B 10~60A, 第三段階を超える使用量" do
      random_usage = rand((EP_planB_SET[:rate].keys[2] + 1)..1000)
      simulator = Simulator.new(random_amp, random_usage)
      expected_charge =  EP_planB_SET[:basicChargeRate] * random_amp + EP_planB_SET[:rate].values[0] * EP_planB_SET[:rate].keys[1] + EP_planB_SET[:rate].values[1] * (EP_planB_SET[:rate].keys[2] - EP_planB_SET[:rate].keys[1]) + EP_planB_SET[:rate].values[2] * (random_usage - EP_planB_SET[:rate].keys[2])
      expect(simulator.ep_planB_bill).to eq expected_charge.floor
    end
  end

  describe '#tg_zuttomoDenki1' do
    it "東京ガスずっとも電気１ 30~60A, 第二段階を超えない使用量" do
      random_usage = rand(0..TG_ZUTTOMO_SET[:rate].keys[1])
      simulator = Simulator.new(random_amp2, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * random_amp2 + TG_ZUTTOMO_SET[:rate].values[0] * random_usage
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end

    it "東京ガスずっとも電気１ 30~60A, 第三段階を超えない使用量" do
      random_usage = rand((TG_ZUTTOMO_SET[:rate].keys[1] + 1)..TG_ZUTTOMO_SET[:rate].keys[2])
      simulator = Simulator.new(random_amp2, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * random_amp2 + TG_ZUTTOMO_SET[:rate].values[0] * TG_ZUTTOMO_SET[:rate].keys[1] + TG_ZUTTOMO_SET[:rate].values[1] * (random_usage - TG_ZUTTOMO_SET[:rate].keys[1])
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end

    it "東京ガスずっとも電気１ 30~60A, 第三段階を超える使用量" do
      random_usage = rand((TG_ZUTTOMO_SET[:rate].keys[2] + 1)..1000)
      simulator = Simulator.new(random_amp2, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * random_amp2 + TG_ZUTTOMO_SET[:rate].values[0] * TG_ZUTTOMO_SET[:rate].keys[1] + TG_ZUTTOMO_SET[:rate].values[1] * (TG_ZUTTOMO_SET[:rate].keys[2] - TG_ZUTTOMO_SET[:rate].keys[1]) + TG_ZUTTOMO_SET[:rate].values[2] * (random_usage - TG_ZUTTOMO_SET[:rate].keys[2])
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end

    it "東京ガスずっとも電気１ 30Aに満たない, 第二段階を超えない使用量" do
      random_usage = rand(0..TG_ZUTTOMO_SET[:rate].keys[1])
      simulator = Simulator.new(random_amp3, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * 30 + TG_ZUTTOMO_SET[:rate].values[0] * random_usage
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end

    it "東京ガスずっとも電気１ 30Aに満たない, 第三段階を超えない使用量" do
      random_usage = rand((TG_ZUTTOMO_SET[:rate].keys[1] + 1)..TG_ZUTTOMO_SET[:rate].keys[2])
      simulator = Simulator.new(random_amp3, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * 30 + TG_ZUTTOMO_SET[:rate].values[0] * TG_ZUTTOMO_SET[:rate].keys[1] + TG_ZUTTOMO_SET[:rate].values[1] * (random_usage - TG_ZUTTOMO_SET[:rate].keys[1])
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end

    it "東京ガスずっとも電気１ 30Aに満たない, 第三段階を超える使用量" do
      random_usage = rand((TG_ZUTTOMO_SET[:rate].keys[2] + 1)..1000)
      simulator = Simulator.new(random_amp3, random_usage)
      expected_charge =  TG_ZUTTOMO_SET[:basicChargeRate] * 30 + TG_ZUTTOMO_SET[:rate].values[0] * TG_ZUTTOMO_SET[:rate].keys[1] + TG_ZUTTOMO_SET[:rate].values[1] * (TG_ZUTTOMO_SET[:rate].keys[2] - TG_ZUTTOMO_SET[:rate].keys[1]) + TG_ZUTTOMO_SET[:rate].values[2] * (random_usage - TG_ZUTTOMO_SET[:rate].keys[2])
      expect(simulator.tg_zuttomoDenki1_bill).to eq expected_charge.floor
    end
  end

  describe "#simulate" do
    context('引数に誤りがない場合') do 

      context("どのプランの規定にも変更がない場合") do
        it "puts an array of hashes summaring each plan's data" do
          simulator = Simulator.new(random_amp, random_usage)
          output = [
            {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{simulator.ep_planB_bill}"},
            {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{simulator.looop_homePlan_bill}"},
            {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{simulator.tg_zuttomoDenki1_bill}"}
          ]
          output = output.sort{|a,b| a[:price] <=> b[:price]}
          expect{simulator.simulate}.to output("#{output}\n").to_stdout
        end
      end

      context("もし東電従量電灯Bの設定に変更があった場合") do
        it "puts an array of hashes summaring each plan's data(レートを追加した時）" do
          Simulator.EP_planB_SET[:rate].update({400 => 50.00})
          simulator = Simulator.new(random_amp, random_usage)
          output = [
            {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{simulator.ep_planB_bill}"},
            {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{simulator.looop_homePlan_bill}"},
            {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{simulator.tg_zuttomoDenki1_bill}"}
          ]
          output = output.sort{|a,b| a[:price] <=> b[:price]}
          expect{simulator.simulate}.to output("#{output}\n").to_stdout
        end
      end

      context("もし東京ガスずっとも電気１の設定に変更があった場合") do
        it "puts an array of hashes summaring each plan's data（正しい順序でないレートを誤まって設定した時）" do
          Simulator.TG_ZUTTOMO_SET[:rate].replace({300 => 30.57, 120 => 26.48, 0 => 19.88})
          simulator = Simulator.new(random_amp, random_usage)
          output = [
            {provider_name: "東京電力エナジーパートナー", plan_name: "従量電灯B", price: "#{simulator.ep_planB_bill}"},
            {provider_name: "Looop電気", plan_name: "おうちプラン", price: "#{simulator.looop_homePlan_bill}"},
            {provider_name: "東京ガス", plan_name: "ずっとも電気１", price: "#{simulator.tg_zuttomoDenki1_bill}"}
          ]
          output = output.sort{|a,b| a[:price] <=> b[:price]}
          expect{simulator.simulate}.to output("#{output}\n").to_stdout
        end
      end
    end

    context('引数に誤りがある場合') do 
      it "puts error message if ampere is invalid" do
        simulator = Simulator.new("a", random_usage)
        expect{simulator.simulate}.to output("アンペアは10,15,20,30,40,50,60のうちから一つを選んで入力してください (例) simulator = Simulator.new(30, 100)\n").to_stderr
      end

      it "puts error message if usage is invalid" do
        simulator = Simulator.new(random_amp, "100")
        expect{simulator.simulate}.to output("電気の使用量は整数を入力してください。(例) simulator = Simulator.new(30, 100)\n").to_stderr
      end
    end
  end
end