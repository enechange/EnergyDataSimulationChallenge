require 'spec_helper'

describe City do

  describe 'all() method' do
    before do
      city = City.new(:name => 'Tokyo')
      city.save
      @cities = City.all
    end
    context "normal case" do
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
      it "has nil total energy prodcution on index 0" do
        result = @cities[0].total_energy_production
        expect(result).to eq(nil)
      end
    end
  end

  describe 'all() method with with_count_house and with_total_energy_production' do
    before do
      city = City.new(:name => 'Tokyo')
      city.save
      @cities = City.all(true, true)
    end
    context "normal case" do
      it "has 4 as length" do
        result = @cities.length
        expect(result).to eq(4)
      end
      it "has 11 as count on index 0" do
        result = @cities[0].count_house
        expect(result).to eq(11)
      end
      it "has 162575 total energy prodcution on index 0" do
        result = @cities[0].total_energy_production
        expect(result).to eq(162575)
      end
    end
    context "newly added case" do
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

  describe 'find() method id = 1' do
    before do
      @city = City.find(1)
    end
    context "normal case" do
      it "has 'Cambridge' on index 0" do
        result = @city.name
        expect(result).to eq('Cambridge')
      end
      it "has nil as count on index 0" do
        result = @city.count_house
        expect(result).to eq(nil)
      end
      it "has nil total energy prodcution on index 0" do
        result = @city.total_energy_production
        expect(result).to eq(nil)
      end
    end
  end

  describe 'find() method id = 1 with with_count_house and with_total_energy_production' do
    before do
      @city = City.find(1, true, true)
    end
    context "normal case" do
      it "has 'Cambridge' on index 0" do
        result = @city.name
        expect(result).to eq('Cambridge')
      end
      it "has 11 as count on index 0" do
        result = @city.count_house
        expect(result).to eq(11)
      end
      it "has 162575 total energy prodcution on index 0" do
        result = @city.total_energy_production
        expect(result).to eq(162575)
      end
    end
  end

  describe 'find() method on id = 4 with with_count_house and with_total_energy_production' do
    before do
      city = City.create(:name => "Tokyo")
      @city = City.find(City.all().last.id, true, true) # id is unknown..
     end
    context "normal case" do
      it "has 'Tokyo' on index 0" do
        result = @city.name
        expect(result).to eq('Tokyo')
      end
      it "has 0 as count on index 0" do
        result = @city.count_house
        expect(result).to eq(0)
      end
      it "has 0 total energy prodcution on index 0" do
        result = @city.total_energy_production
        expect(result).to eq(0)
      end
    end
  end

  describe 'energies() method' do
    before do
      city = City.create(:name => "Tokyo")
      @energies = City.energies()
     end
    context "normal case" do
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
      it "has date 2011-07 on column 0" do
        result = @energies[:data][1][0]
        expect(result).to eq('2011-07')
      end
      it "has value of Cambridge 6777 on column 1" do
        result = @energies[:data][1][1]
        expect(result).to eq(6777)
      end
      it "has value of London 18860 on column 2" do
        result = @energies[:data][1][2]
        expect(result).to eq(18860)
      end
      it "has value of Oxford 5871 on column 3" do
        result = @energies[:data][1][3]
        expect(result).to eq(5871)
      end
      it "has value of Tokyo 0 on column 4" do
        result = @energies[:data][1][4]
        expect(result).to eq(0)
      end
    end
  end

end
