require "rails_helper"

RSpec.describe DataSet, type: :model do
  describe "#with_house_ids" do
    subject { DataSet.with_house_ids(house_ids).to_sql }

    context "house_ids が1件字以上の時" do
      let(:house_ids) { [1] }
      it "クエリに条件が付与される" do
        expect(subject).to include "house_id"
      end
    end

    context "house_ids が0件の時" do
      let(:house_ids) { [] }
      it "クエリに条件が付与されない" do
        expect(subject).not_to include "house_id"
      end
    end
  end
end
