require 'rails_helper'
describe Datum do
  describe '#create' do
    it "is invalid without a csv_id" do
     datum = build(:datum, csv_id: nil)
     datum.valid?
     expect(datum.errors[:csv_id]).to include("can't be blank")
    end

    it "is invalid without a wrong type of input filled in csv_id" do
     datum = build(:datum, csv_id: "a")
     datum.valid?
     expect(datum.errors[:csv_id]).to include("is not a number")
    end
    
    it "is invalid without a label" do
      datum = build(:datum, label: nil)
      datum.valid?
      expect(datum.errors[:label]).to include("can't be blank")
    end

    it "is invalid without a wrong type of input filled in label" do
     datum = build(:datum, label: "a")
     datum.valid?
     expect(datum.errors[:label]).to include("is not a number")
    end

    it "is invalid without a house" do
     datum = build(:datum, house: nil)
     datum.valid?
     expect(datum.errors[:house]).to include("must exist")
    end
    
    it "is invalid without a year" do
     datum = build(:datum, year: nil)
     datum.valid?
     expect(datum.errors[:year]).to include("can't be blank")
    end

    it "is invalid without a wrong type of input filled in year" do
     datum = build(:datum, year: "a")
     datum.valid?
     expect(datum.errors[:year]).to include("is not a number")
    end
    
    it "is invalid if inputted year is less than 0" do
      datum = build(:datum, year: -1)
      datum.valid?
      expect(datum.errors[:year]).to include("must be greater than 0")
    end

    it "is invalid without a month" do
      datum = build(:datum, month: nil)
      datum.valid?
      expect(datum.errors[:month]).to include("can't be blank")
    end

    it "is invalid without a wrong type of input filled in month" do
      datum = build(:datum, month: "a")
      datum.valid?
      expect(datum.errors[:month]).to include("is not a number")
    end
    
    it "is invalid if inputted month is less than 0" do
     datum = build(:datum, month: -1)
     datum.valid?
     expect(datum.errors[:month]).to include("must be greater than 0")
    end

    it "is invalid if inputted month is greater than 13" do
     datum = build(:datum, month: 13)
     datum.valid?
     expect(datum.errors[:month]).to include("must be less than 13")
    end

    it "is invalid without a temperature" do
     datum = build(:datum, temperature: nil)
     datum.valid?
     expect(datum.errors[:temperature]).to include("can't be blank")
    end

    it "is invalid without a daylight" do
      datum = build(:datum, daylight: nil)
      datum.valid?
      expect(datum.errors[:daylight]).to include("can't be blank")
     end

    it "is invalid without a energy_production" do
      datum = build(:datum, energy_production: nil)
      datum.valid?
      expect(datum.errors[:energy_production]).to include("can't be blank")
     end

    it "is invalid without a wrong type of input filled in energy_production" do
      datum = build(:datum, energy_production: "a")
      datum.valid?
      expect(datum.errors[:energy_production]).to include("is not a number")
     end
  end
end