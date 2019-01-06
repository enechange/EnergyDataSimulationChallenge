require 'rails_helper'

RSpec.describe House, type: :model do
  describe '#with_city' do
    subject { House.with_city(city).to_sql }
    
    context 'cityが1字以上の時' do
      let(:city) { 'any place' }
      it 'クエリに条件が付与される' do
        is_expected.to include 'city'
      end
    end

    context 'cityが空文字の時' do
      let(:city) { '' }
      it 'クエリに条件が付与されない' do
        is_expected.not_to include 'city'
      end
    end

    context 'cityがnilの時' do
      let(:city) { nil }
      it 'クエリに条件が付与されない' do
        is_expected.not_to include 'city'
      end
    end
  end

  describe '#with_num_of_people' do
    subject { House.with_num_of_people(num_of_people).to_sql }

    context 'num_of_peopleが0以上の時' do
      let(:num_of_people) { 1 }
      it 'クエリに条件が付与される' do
        is_expected.to include 'num_of_people'
      end
    end

    context 'num_of_peopleが0の時' do
      let(:num_of_people) { 0 }
      it 'クエリに条件が付与されない' do
        is_expected.not_to include 'num_of_people'
      end
    end

    context 'num_of_peopleがnilの時' do
      let(:num_of_people) { nil }
      it 'クエリに条件が付与されない' do
        is_expected.not_to include 'num_of_people'
      end
    end
  end
end
