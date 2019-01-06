require 'rails_helper'

RSpec.describe Highchart::IndexForm do
  describe '#in_time?' do
    using RSpec::Parameterized::TableSyntax

    subject { form.in_time?(current_date) }

    let(:form) { Highchart::IndexForm.new(params) }
    let(:params) { {}.merge(track_from_with_key).merge(track_to_with_key) }
    let(:track_from_with_key) { i_track_from ? { track_from: i_track_from.to_s } : {} }
    let(:track_to_with_key) { i_track_to ? { track_to: i_track_to.to_s } : {} }

    context '期間指定にばらつきがある時' do
      let(:current_date) { i_current_date ? Time.zone.parse(i_current_date.to_s) : nil }

      where(:i_track_from, :i_track_to, :i_current_date, :expected) do
        201901 | 201902 | 20181231 | false  # current < from    < to
        201901 | 201902 | 20190101 | true   # from    = current < to
        201901 | 201902 | 20190131 | true   # from    < current < to
        201901 | 201902 | 20190201 | true   # from    < current = to
        201901 | 201902 | 20190202 | false  # from    < to      < current
        201901 | nil    | 20181231 | false  # current < from    < nil
        201901 | nil    | 20190101 | true   # from    < current < nil
        nil    | 201902 | 20190101 | true   # nil     < current < to
        nil    | 201902 | 20190202 | false  # nil     < to      < current
        nil    | nil    | 20190101 | true   # nil     < current < nil
        201902 | 201901 | 20190101 | false  # to      < from    < current
      end

      with_them do
        it '適切に期間が評価される' do
          is_expected.to eq expected
        end
      end
    end
  end
end
