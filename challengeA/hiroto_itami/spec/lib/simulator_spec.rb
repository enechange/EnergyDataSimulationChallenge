# frozen_string_literal: true

require_relative '../../lib/simulator'

RSpec.describe do
  describe '#simulator' do
    subject { Simulator.new(ampere:, kwh:).simulator }

    context '入力値が正常系の場合' do
      let(:ampere) { 40 }
      let(:kwh) { 400 }

      it '結果が出力されること' do
        result = <<~RESULT
          {:provider_name=>"東京電力エナジーパートナー", :plan_name=>"従量電灯B", :price=>11353}
          {:provider_name=>"Loopでんき", :plan_name=>"おうちプラン", :price=>10560}
          {:provider_name=>"東京ガス", :plan_name=>"ずっとも電気１", :price=>10793}
          {:provider_name=>"JXTGでんき", :plan_name=>"たっぷりプラン", :price=>10804}
        RESULT

        expect { subject }.to output(result).to_stdout
      end
    end

    context '入力値が異常系な場合' do
      describe 'ampere' do
        context '契約範囲外' do
          let(:ampere) { 1 }
          let(:kwh) { 400 }

          it do
            expect { subject }.to output("エラーが発生しました。Simulator::InValidAmpereError\n").to_stdout
          end
        end

        context '負の数' do
          let(:ampere) { -1 }
          let(:kwh) { 400 }

          it do
            expect { subject }.to output("エラーが発生しました。Simulator::InValidAmpereError\n").to_stdout
          end
        end

        context '文字列' do
          let(:ampere) { 'a' }
          let(:kwh) { 400 }

          it do
            expect { subject }.to output("エラーが発生しました。Simulator::InValidAmpereError\n").to_stdout
          end
        end
      end

      describe 'kwh' do
        context '負の数' do
          let(:ampere) { 40 }
          let(:kwh) { -1 }

          it do
            expect { subject }.to output("エラーが発生しました。Simulator::InValidKwhError\n").to_stdout
          end
        end

        context '文字列' do
          let(:ampere) { 40 }
          let(:kwh) { 'a' }

          it do
            expect { subject }.to output("エラーが発生しました。Simulator::InValidKwhError\n").to_stdout
          end
        end
      end
    end
  end
end
