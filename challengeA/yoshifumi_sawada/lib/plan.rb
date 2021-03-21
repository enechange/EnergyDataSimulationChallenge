require "csv"
require "pry"

class Plan
  def self.import(path)
    #全てを読込、配列を作成
    CSV.read("csv/plans.csv", headers: true).map do |row|
      {
        provider_name: row["provider_name"],
        plan_name: row["plan_name"]
      }
    end
  end
end