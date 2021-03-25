require "csv"
require "pry"

class Usage_charge
  def self.import(path)
    #全てを読込、配列を作成
    CSV.read("csv/tokyo_energy_partner/usage_charge.csv", headers: true).map do |row|
      {
        kwh_from: row["kwh_from"],
        kwh_to: row["kwh_to"],
        unit_price: row["unit_price"]
      }
    end
  end

  def self.import2(path)
    #全てを読込、配列を作成
    CSV.read("csv/loop/usage_charge.csv", headers: true).map do |row|
      {
        kwh: row["kwh"],
        unit_price: row["unit_price"]
      }
    end
  end

  def self.import3(path)
    #全てを読込、配列を作成
    CSV.read("csv/tokyogas/usage_charge.csv", headers: true).map do |row|
      {
        kwh_from: row["kwh_from"],
        kwh_to: row["kwh_to"],
        unit_price: row["unit_price"]
      }
    end
  end

  def self.import4(path)
    #全てを読込、配列を作成
    CSV.read("csv/jxtg/usage_charge.csv", headers: true).map do |row|
      {
        kwh_from: row["kwh_from"],
        kwh_to: row["kwh_to"],
        unit_price: row["unit_price"]
      }
    end
  end
end