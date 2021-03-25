require "csv"
require "pry"

class Basic_charge
  def self.import(path)
    #全てを読込、配列を作成
    CSV.read("csv/tokyo_energy_partner/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end
  end

  # 以下、共通化すること
  def self.import2(path)
    CSV.read("csv/loop/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end
  end

  def self.import3(path)
    CSV.read("csv/tokyogas/basic_charge.csv", headers: true).map do |row|
      {
        amp: row["amp"],
        basic_charge: row["basic_charge"]
      }
    end
  end
end