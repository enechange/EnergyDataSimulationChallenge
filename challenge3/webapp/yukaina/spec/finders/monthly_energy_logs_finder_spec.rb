require "rails_helper"

RSpec.describe MonthlyEnergyLogsFinder do
  # rubocop:disable Naming/VariableNumber
  before do
    monthly_label_00 = FactoryBot.create(:monthly_label, id: 0, year: 2011, month: 7)
    monthly_label_01 = FactoryBot.create(:monthly_label, id: 1, year: 2011, month: 8)
    city_01 = FactoryBot.create(:city, name: "Tokyo")
    city_02 = FactoryBot.create(:city, name: "Osaka")
    family_01 = FactoryBot.create(:family, first_name: "Hoge", last_name: "Fuga")
    family_02 = FactoryBot.create(:family, first_name: "Foo", last_name: "Bar")
    house_01 = FactoryBot.create(:house, city: city_01, family: family_01)
    house_02 = FactoryBot.create(:house, city: city_02, family: family_02)
    FactoryBot.create(
      :monthly_energy_log,
      monthly_label: monthly_label_00,
      house: house_01,
      family: house_01.family,
      temperature: 10.0,
      daylight: 20.0,
      production_volume: 100,
    )
    FactoryBot.create(
      :monthly_energy_log,
      monthly_label: monthly_label_00,
      house: house_02,
      family: house_02.family,
      temperature: 10.2,
      daylight: 20.2,
      production_volume: 102,
    )
    FactoryBot.create(
      :monthly_energy_log,
      monthly_label: monthly_label_01,
      house: house_01,
      family: house_01.family,
      temperature: 20.1,
      daylight: 30.1,
      production_volume: 111,
    )
    FactoryBot.create(
      :monthly_energy_log,
      monthly_label: monthly_label_01,
      house: house_02,
      family: house_02.family,
      temperature: 20.3,
      daylight: 30.3,
      production_volume: 113,
    )
  end
  # rubocop:enable Naming/VariableNumber

  describe "averages" do
    it "temperature, daylight, temperature の平均が出力されること" do
      logs = MonthlyEnergyLogsFinder.averages
      expect(logs.first["avarage_temperature"].floor(2).to_f).to eq 10.1
      expect(logs.first["avarage_daylight"].floor(2).to_f).to eq 20.1
      expect(logs.first["avarage_production_volume"]).to eq 101
      expect(logs.second["avarage_temperature"].floor(2).to_f).to eq 20.2
      expect(logs.second["avarage_daylight"].floor(2).to_f).to eq 30.2
      expect(logs.second["avarage_production_volume"]).to eq 112
    end
  end

  describe "by_city" do
    it "都市別のtemperature, daylight, temperature の合計が出力されること" do
      logs = MonthlyEnergyLogsFinder.by_city
      expect(logs.first["total_production_volume"]).to eq 211
      expect(logs.second["total_production_volume"]).to eq 215
    end
  end
end
