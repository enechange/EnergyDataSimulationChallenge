require "rails_helper"
require "csv"

RSpec.describe HouseDataImportService do
  describe "call" do
    subject { HouseDataImportService.new(csv_row: csv_row).call }

    let(:csv_row) do
      CSV::Row.new(
        [:id, :first_name, :last_name, :city_name, :num_of_people, :has_child],
        [1, "Carolyn", "Flores", "London", 2, true],
      )
    end

    context "cities が 0 件の場合" do
      context "families が 0 件の場合" do
        it "citiesも、familiesも、housesも、1 レコード増えていること " do
          expect { subject }.to change { City.count }.by(+1).
                                  and change { Family.count }.by(+1).
                                        and change { House.count }.by(+1)
        end
      end

      context "すでにある families の 1 件は別名の場合" do
        before do
          # id は、csv データで固定で入ってくるので、1 以外として、 通常ありえない -1 を設定
          FactoryBot.create(:family, id: -1, first_name: "Janet", last_name: "Baker", num_of_people: 2, has_child: true)
        end

        it "citiesも、familiesも、housesも、1 レコード増えていること " do
          expect { subject }.to change { City.count }.by(+1).
                                  and change { Family.count }.by(+1).
                                        and change { House.count }.by(+1)
        end
      end

      context "すでにある families の 1 件は同姓同名かつ同じ家族構成の Family の場合" do
        before do
          # id は、csv データで固定で入ってくるので、1 以外として、 通常ありえない -1 を設定
          FactoryBot.create(:family, id: -1, first_name: "Carolyn", last_name: "Flores", num_of_people: 2, has_child: true)
        end

        it "citiesも、familiesも、housesも、1 レコード増えていること " do
          expect { subject }.to change { City.count }.by(+1).
                                  and change { Family.count }.by(+1).
                                        and change { House.count }.by(+1)
        end
      end
    end

    context "cities が 1 件の場合" do
      context "重複しない都市名の場合" do
        before do
          FactoryBot.create(:city, name: "Cambridge")
        end

        it "citiesも、familiesも、housesも、1 レコード増えていること " do
          expect { subject }.to change { City.count }.by(+1).
                                  and change { Family.count }.by(+1).
                                        and change { House.count }.by(+1)
        end
      end

      context "重複する都市名の場合" do
        before do
          FactoryBot.create(:city, name: "London")
        end

        it "cities はそのまま、families、houses は 1 レコード増えていること " do
          expect { subject }.to change { City.count }.by(0).
                                  and change { Family.count }.by(+1).
                                        and change { House.count }.by(+1)
        end
      end
    end
  end
end
