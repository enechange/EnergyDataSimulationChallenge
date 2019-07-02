require "rails_helper"
require "csv"

RSpec.describe MonthlyEnergyLogsImportService do
  describe "call" do
    subject { MonthlyEnergyLogsImportService.new(csv_row: csv_row).call }

    let(:csv_row) do
      CSV::Row.new(
        [:id, :monthly_label_id, :house_id, :year, :month, :temperature, :daylight, :production_volume],
        [2, 2, 1, 2011, 8, 25.8, 169.7, 731],
      )
    end
    before do
      FactoryBot.create(:house)
    end

    context "monthly_labels が 0 件の場合" do
      it "monthly_labelsも、monthly_energy_logsも、1 レコード増えていること " do
        expect { subject }.to change { MonthlyLabel.count }.by(+1).
                                and change { MonthlyEnergyLog.count }.by(+1)
      end
    end

    context "monthly_labels が 1 件の場合" do
      context "すでに存在する monthly_labels とは重複しない場合" do
        before do
          FactoryBot.create(:monthly_label, id: 1, year: 2011, month: 7)
        end

        it "monthly_labelsも、monthly_energy_logsも、1 レコード増えていること " do
          expect { subject }.to change { MonthlyLabel.count }.by(+1).
                                  and change { MonthlyEnergyLog.count }.by(+1)
        end
      end

      context "すでに存在する monthly_labels とは重複する場合" do
        before do
          FactoryBot.create(:monthly_label, id: 2, year: 2011, month: 8)
        end

        it "monthly_labels はそのまま、monthly_energy_logs は、1 レコード増えていること " do
          expect { subject }.to change { MonthlyLabel.count }.by(0).
                                  and change { MonthlyEnergyLog.count }.by(+1)
        end
      end
    end
  end
end
