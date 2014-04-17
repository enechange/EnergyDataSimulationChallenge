require 'spec_helper'

describe House do

  describe 'all()' do
    before do
      house = House.create(:firstname => 'Fisrt', :lastname => 'Last', :city_id => 1, :num_of_people => 2, :has_child => 1)
    end
    context "normal case" do
      before do
        @houses = House.all
      end
      it "has 51 as length" do
        result = @houses.length
        expect(result).to eq(51)
      end
    end
  end

  describe 'energies()' do
    context "with arg id = 1" do
      before do
        @energies = House.energies(1)
      end
      it "has 'data' key" do
        result = @energies.has_key?(:data)
        expect(result).to be_true
      end
      it "has 24 rows" do
        result = @energies[:data].length
        expect(result).to eq(25)
      end
      it "has 3 columns on header" do
        result = @energies[:data][0].length
        expect(result).to eq(3)
      end
      it "has 'date' on column 0" do
        result = @energies[:data][0][0]
        expect(result).to eq('date')
      end
      it "has 'Energy Production' on column 1" do
        result = @energies[:data][0][1]
        expect(result).to eq('Energy Production')
      end
      it "has 'Daylight' on column 2" do
        result = @energies[:data][0][2]
        expect(result).to eq('Daylight')
      end
      it "has 3 columns on data" do
        result = @energies[:data][1].length
        expect(result).to eq(3)
      end
      it "has date 2011-07 on column 0" do
        result = @energies[:data][1][0]
        expect(result).to eq('2011-07')
      end
      it "has value of 740 on column 1" do
        result = @energies[:data][1][1]
        expect(result).to eq(740)
      end
      it "has value of 178.9 on column 2" do
        result = @energies[:data][1][2]
        expect(result).to eq(178.9)
      end
    end
  end

  describe 'count_by_city_id()' do
    context "without args" do
      before do
        City.create(:name => 'Tokyo')
        @count = House.count_by_city_id
      end
      it "has 3 length" do
        result = @count.length
        expect(result).to eq(3)
      end
      it "has 11 for Cambridge as key = 1" do
        result = @count[1]
        expect(result).to eq(11)
      end
      it "has 30 for London as key = 2" do
        result = @count[2]
        expect(result).to eq(30)
      end
      it "has 9 for Oxford as key = 3" do
        result = @count[3]
        expect(result).to eq(9)
      end
      it "has not value for Tokyo" do
        @city = City.all().last
        result = @count.has_key?(@city.id)
        expect(result).to be_false
      end
    end
    context "with args id = 1" do
      before do
        @count = House.count_by_city_id(1)
      end
      it "has 11 as value" do
        result = @count
        expect(result).to eq(11)
      end
    end
    context "with args id = not exists" do
      before do
        @count = House.count_by_city_id(4)
      end
      it "has nil as value" do
        result = @count
        expect(result).to eq(nil)
      end
    end
  end

end
