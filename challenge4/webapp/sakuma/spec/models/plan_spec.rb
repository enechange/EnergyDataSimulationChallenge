require 'rails_helper'

RSpec.describe Plan, type: :model do

  let(:no_night_plan) do
    Plan.new(
      name: "Day time only",
      day_time: [ [ nil, 120, 19.43], [ 120, 300, 25.91], [ 300, nil, 29.93] ],
      night_time: nil,
      night_time_range: nil,
    )
  end

  let(:night_plan) do
    Plan.new(
      name: "Day time only",
      day_time: [ [ nil, 90, 24.03], [ 90, 230, 32.03], [ 230, nil, 37.00] ],
      night_time: [ nil, nil, 12.48] ,
      night_time_range: [
        true, true, true, true, true, false, false, false, false,
        false, false, false, false, false, false, false, false,
        false, false, false, false, true, true, true
      ]
    )
  end

  describe '#has_night_plan?' do

    subject { this_plan.has_night_plan? }

    context 'when no night plan' do
      let(:this_plan) { no_night_plan }
      it { is_expected.to be false }
    end

    context 'when night plan' do
      let(:this_plan) { night_plan }
      it { is_expected.to be true }
    end
  end

  describe '#night_time?' do
    subject { this_plan.night_time?(hour) }

    shared_examples_for 'should be night' do |hour|
      it { expect(this_plan.night_time?(hour)).to be true}
    end
    shared_examples_for 'should not be night' do |hour|
      it { expect(this_plan.night_time?(hour)).to be false}
    end

    context 'when night time plan' do
      let(:this_plan) { night_plan }

      it_should_behave_like 'should be night', 1
      it_should_behave_like 'should be night', 5
      it_should_behave_like 'should not be night', 6
      it_should_behave_like 'should not be night', 13
      it_should_behave_like 'should not be night', 21
      it_should_behave_like 'should be night', 22
      it_should_behave_like 'should be night', 24

      # invalid values
      it_should_behave_like 'should not be night', 100
      it_should_behave_like 'should not be night', 'aaa'
      it_should_behave_like 'should not be night', nil
    end

    context 'about no night time plan' do
      let(:this_plan) { no_night_plan }

      it_should_behave_like 'should not be night', 1
      it_should_behave_like 'should not be night', 5
      it_should_behave_like 'should not be night', 6
      it_should_behave_like 'should not be night', 12
      it_should_behave_like 'should not be night', 21
      it_should_behave_like 'should not be night', 22
      it_should_behave_like 'should not be night', 24
    end
  end

end
