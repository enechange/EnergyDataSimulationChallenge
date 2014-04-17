require 'spec_helper'

describe City do

  describe 'all()' do
    before do
      city = City.create(:name => 'Tokyo')
    end
    context "without args" do
      before do
        @cities = City.all
      end
      it "has 4 as length" do
        result = @cities.length
        expect(result).to eq(4)
      end
      it "has 'Cambridge' on index 0" do
        result = @cities[0].name
        expect(result).to eq('Cambridge')
      end
      it "has 'London' on index 1" do
        result = @cities[1].name
        expect(result).to eq('London')
      end
      it "has 'Oxford' on index 2" do
        result = @cities[2].name
        expect(result).to eq('Oxford')
      end
      it "has 'Tokyo' on index 3" do
        result = @cities[3].name
        expect(result).to eq('Tokyo')
      end
      it "has nil as count on index 0" do
        result = @cities[0].count_house
        expect(result).to eq(nil)
      end
      it "has nil as total energy prodcution on index 0" do
        result = @cities[0].total_energy_production
        expect(result).to eq(nil)
      end
    end
    context 'with args with_count_house and with_total_energy_production' do
      before do
        @cities = City.all(true, true)
      end
      it "has 4 as length" do
        result = @cities.length
        expect(result).to eq(4)
      end
      it "has 11 as count on index 0" do
        result = @cities[0].count_house
        expect(result).to eq(11)
      end
      it "has 162575 as total energy prodcution on index 0" do
        result = @cities[0].total_energy_production
        expect(result).to eq(162575)
      end
      it "has 0 as count on index 3" do
        result = @cities[3].count_house
        expect(result).to eq(0)
      end
      it "has 0 as total energy prodcution on index 3" do
        result = @cities[3].total_energy_production
        expect(result).to eq(0)
      end
    end
  end

  describe 'find()' do
    context "with arg id = 1" do
      before do
        @city = City.find(1)
      end
      it "has 'Cambridge'" do
        result = @city.name
        expect(result).to eq('Cambridge')
      end
      it "has nil as count" do
        result = @city.count_house
        expect(result).to eq(nil)
      end
      it "has nil as total energy prodcution" do
        result = @city.total_energy_production
        expect(result).to eq(nil)
      end
    end
    context 'with arg id = 1 with with_count_house and with_total_energy_production' do
      before do
        @city = City.find(1, true, true)
      end
      it "has 'Cambridge'" do
        result = @city.name
        expect(result).to eq('Cambridge')
      end
      it "has 11 as count" do
        result = @city.count_house
        expect(result).to eq(11)
      end
      it "has 162575 as total energy prodcution" do
        result = @city.total_energy_production
        expect(result).to eq(162575)
      end
    end
    context 'with arg id = (new id) with with_count_house and with_total_energy_production' do
      before do
        city = City.create(:name => "Tokyo")
        @city = City.find(City.all().last.id, true, true) # id is unknown..
      end
      it "has 'Tokyo' as name" do
        result = @city.name
        expect(result).to eq('Tokyo')
      end
      it "has 0 as count" do
        result = @city.count_house
        expect(result).to eq(0)
      end
      it "has 0 as total energy prodcution" do
        result = @city.total_energy_production
        expect(result).to eq(0)
      end
    end
  end

  describe 'energies()' do
    before do
      city = City.create(:name => "Tokyo")
    end
    context "without args" do
      before do
        @energies = City.energies()
      end
      it "has 'data' key" do
        result = @energies.has_key?(:data)
        expect(result).to be_true
      end
      it "has 25 rows" do
        result = @energies[:data].length
        expect(result).to eq(25)
      end
      it "has 5 columns on header" do
        result = @energies[:data][0].length
        expect(result).to eq(5)
      end
      it "has 'date' on column 0" do
        result = @energies[:data][0][0]
        expect(result).to eq('date')
      end
      it "has 'Cambridge' on column 1" do
        result = @energies[:data][0][1]
        expect(result).to eq('Cambridge')
      end
      it "has 'London' on column 2" do
        result = @energies[:data][0][2]
        expect(result).to eq('London')
      end
      it "has 'Oxford' on column 3" do
        result = @energies[:data][0][3]
        expect(result).to eq('Oxford')
      end
      it "has 'Tokyo' on column 4" do
        result = @energies[:data][0][4]
        expect(result).to eq('Tokyo')
      end
      it "has 5 columns on data" do
        result = @energies[:data][1].length
        expect(result).to eq(5)
      end
      it "has '2011-07' as value of date on column 0" do
        result = @energies[:data][1][0]
        expect(result).to eq('2011-07')
      end
      it "has 6777 as value of Cambridge on column 1" do
        result = @energies[:data][1][1]
        expect(result).to eq(6777)
      end
      it "has 18860 as value of London on column 2" do
        result = @energies[:data][1][2]
        expect(result).to eq(18860)
      end
      it "has 5871 as value of Oxford on column 3" do
        result = @energies[:data][1][3]
        expect(result).to eq(5871)
      end
      it "has 0 as value of Tokyo on column 4" do
        result = @energies[:data][1][4]
        expect(result).to eq(0)
      end
    end
    context 'with arg id = 1' do
      before do
        @energies = City.energies(1)
      end
      it "has 'data' key" do
        result = @energies.has_key?(:data)
        expect(result).to be_true
      end
      it "has 25 rows" do
        result = @energies[:data].length
        expect(result).to eq(25)
      end
      it "has 2 columns on header" do
        result = @energies[:data][0].length
        expect(result).to eq(2)
      end
      it "has 'date' on column 0" do
        result = @energies[:data][0][0]
        expect(result).to eq('date')
      end
      it "has 'Energy Production' on column 1" do
        result = @energies[:data][0][1]
        expect(result).to eq('Energy Production')
      end
      it "has 2 columns on data" do
        result = @energies[:data][1].length
        expect(result).to eq(2)
      end
      it "has '2011-07' as date on column 0" do
        result = @energies[:data][1][0]
        expect(result).to eq('2011-07')
      end
      it "has 6777 as value of Cambridge on column 1" do
        result = @energies[:data][1][1]
        expect(result).to eq(6777)
      end
    end
  end

end
