RSpec.describe Murasaki::Simulator do
  shared_examples :return_tepco do |price|
    it "includes TEPCO with amount #{price}" do
      expect(subject).to include({ plan_name: '従量電灯B', price: price, provider_name: '東京電力エナジーパートナー' })
    end
  end

  shared_examples :return_tokyo_gas do |price|
    it "includes Tokyo GAS with amount #{price}" do
      expect(subject).to include({ plan_name: 'ずっとも電気１', price: price, provider_name: '東京ガス' })
    end
  end

  shared_examples :return_looop_denki do |price|
    it "includes Looop Denki with amount #{price}" do
      expect(subject).to include({ plan_name: 'おうちプラン', price: price, provider_name: 'Looopでんき' })
    end
  end

  describe '#simulate' do
    subject { described_class.new(ampere, kwh).simulate }
    let(:kwh) { 140 }

    context 'when given 10A' do
      let(:ampere) { 10 }

      it_behaves_like :return_tepco, 286 + (120 * 19.88) + (20 * 26.48)
      it_behaves_like :return_looop_denki, 26.40 * 140

      it 'returns 2 estimations' do
        expect(subject.count).to eq(2)
      end
    end

    context 'when given 40A' do
      let(:ampere) { 40 }

      it_behaves_like :return_tepco, 1144 + (120 * 19.88) + (20 * 26.48)
      it_behaves_like :return_looop_denki, 26.40 * 140
      it_behaves_like :return_tokyo_gas, 1144 + (140 * 23.67)

      it 'returns 3 estimations' do
        expect(subject.count).to eq(3)
      end

      context 'and given 400kwh' do
        let(:kwh) { 400 }

        it_behaves_like :return_tepco, 1144 + (120 * 19.88) + (180 * 26.48) + (100 * 30.57)
        it_behaves_like :return_looop_denki, 26.40 * 400
        it_behaves_like :return_tokyo_gas, 1144 + (140 * 23.67) + (210 * 23.88) + (50 * 26.41)
      end
    end

    context 'when given unavailable ampere' do
      let(:ampere) { 70 }

      it { is_expected.to be_empty }
    end
  end
end
