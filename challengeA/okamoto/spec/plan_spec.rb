require 'spec_helper'

RSpec.describe Plan do
  TEPCO = '東京電力エナジーパートナー'
  TEPCO_PLAN1 = '従量電灯B'
  LOOOP = 'Looopでんき'
  LOOOP_PLAN1 = 'おうちプラン'
  TOKYOGAS = '東京ガス'
  TOKYOGAS_PLAN1 = 'ずっとも電気１'
  JXTG = 'JXTGでんき'
  JXTG_PLAN1 = '従量電灯Bたっぷりプラン'

  describe '#show_plans' do
    let(:plans) { Plan.new(amp, power) }
    let(:tepco_plan1_price) { plans.show_plans.find {|plan| plan[:provider_name] == TEPCO && plan[:plan_name] == TEPCO_PLAN1 }[:price] }
    let(:looop_plan1_price) { plans.show_plans.find {|plan| plan[:provider_name] == LOOOP && plan[:plan_name] == LOOOP_PLAN1 }[:price] }
    let(:tokyogas_plan1_price) { plans.show_plans.find {|plan| plan[:provider_name] == TOKYOGAS && plan[:plan_name] == TOKYOGAS_PLAN1 }[:price] }
    let(:jxtg_plan1_price) { plans.show_plans.find {|plan| plan[:provider_name] == JXTG && plan[:plan_name] == JXTG_PLAN1 }[:price] }

    shared_examples 'planが2件ヒットすること' do
      it { expect(plans.show_plans.count).to eq 2 }
    end

    shared_examples 'planが4件ヒットすること' do
      it { expect(plans.show_plans.count).to eq 4 }
    end

    context 'planヒット件数毎のテスト' do
      context '141kwhの場合' do
        let(:power) { 141 }
        context '10Aの場合' do
          let(:amp) { 10 }

          it_behaves_like 'planが2件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (286.0 + 120 * 19.88 + (141 - 120) * 26.48).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (141 * 26.4).floor
          end
        end

        context '60Aの場合' do
          let(:amp) { 60 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (1716.0 + 120 * 19.88 + (141 - 120) * 26.48).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (141 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (1716.0 + 140 * 23.67 + (141 - 140) * 23.88).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (1716.8 + 120 * 19.88 + (141 - 120) * 26.48).floor
          end
        end
      end
    end

    context '従量制プランの境界値テスト' do
      context '30Aのとき' do
        let(:amp) { 30 }
        context '0kwhのとき' do
          let(:power) { 0 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq 858
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq 0
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq 858
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq 858
          end
        end

        context '120kwhのとき' do
          let(:power) { 120 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (120 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 120 * 23.67).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88).floor
          end
        end

        context '140kwhのとき' do
          let(:power) { 140 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88 + (140 - 120) * 26.48).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (140 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 140 * 23.67).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88 + (140 - 120) * 26.48).floor
          end
        end

        context '300kwhのとき' do
          let(:power) { 300 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (300 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 140 * 23.67 + (300 - 140) * 23.88).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48).floor
          end
        end

        context '350kwhのとき' do
          let(:power) { 350 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (350 - 300) * 30.57).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (350 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 140 * 23.67 + (350 - 140) * 23.88).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (350 - 300) * 25.08).floor
          end
        end

        context '600kwhのとき' do
          let(:power) { 600 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (600 - 300) * 30.57).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (600 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 140 * 23.67 + (350 - 140) * 23.88 + (600 - 350) * 26.41).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (600 - 300) * 25.08).floor
          end
        end

        context '601kwhのとき' do
          let(:power) { 601 }

          it_behaves_like 'planが4件ヒットすること'
          it 'tepco_plan1_の価格が正常であること' do
            expect(tepco_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (601 - 300) * 30.57).floor
          end
          it 'looop_plan1_の価格が正常であること' do
            expect(looop_plan1_price).to eq (601 * 26.4).floor
          end
          it 'tokyogas_plan1_の価格が正常であること' do
            expect(tokyogas_plan1_price).to eq (858.0 + 140 * 23.67 + (350 - 140) * 23.88 + (601 - 350) * 26.41).floor
          end
          it 'jxtg_plan1_の価格が正常であること' do
            expect(jxtg_plan1_price).to eq (858.0 + 120 * 19.88 + (300 - 120) * 26.48 + (600 - 300) * 25.08 + (601 - 600) * 26.15).floor
          end
        end
      end
    end
  end
end
