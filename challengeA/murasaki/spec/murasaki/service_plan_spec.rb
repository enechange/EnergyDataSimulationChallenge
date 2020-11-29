RSpec.describe Murasaki::ServicePlan do
  describe '.availables' do
    subject { described_class.availables(ampere, kwh) }
    let(:kwh) { 120 }

    context 'when given available ampere in one or some companies' do
      let(:ampere) { 30 }

      it 'returns matching companies service plan' do
        expect(subject.map { |c| c[:id] }).to contain_exactly('tepco-b', 'loop-denki', 'tokyo-gas')
      end
    end

    context 'when given unavailable ampere' do
      let(:ampere) { 1000 }

      it { is_expected.to be_empty }
    end
  end
end
