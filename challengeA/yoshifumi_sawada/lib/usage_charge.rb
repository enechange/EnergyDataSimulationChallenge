require "csv"
require "pry"
class Usage_charge
  def self.import(path)
  if path[:path].include?("tokyo_energy_partner")
    list = []
    CSV.foreach("csv/tokyo_energy_partner/usage_charge.csv", headers: true) do |row|
    list << row.to_h.transform_values{|v|
      case v
      when "Float::INFINITY"
        Float::INFINITY
      else
        v.to_f
      end
    }
    end
    return list

  elsif path[:path].include?("loop")
    list = []
    CSV.foreach("csv/loop/usage_charge.csv", headers: true) do |row|
    list << row.to_h.transform_values{|v|
      case v
      when "Float::INFINITY"
        Float::INFINITY
      else
        v.to_f
      end
    }
    end
    return list

  elsif  path[:path].include?("tokyogas")
    list = []
    CSV.foreach("csv/tokyogas/usage_charge.csv", headers: true) do |row|
    list << row.to_h.transform_values{|v|
      case v
      when "Float::INFINITY"
        Float::INFINITY
      else
        v.to_f
      end
    }
    end
    return list

  elsif path[:path].include?("jxtg")
    list = []
    CSV.read("csv/jxtg/usage_charge.csv", headers: true).map do |row|
    list << row.to_h.transform_values{|v|
      case v
      when "Float::INFINITY"
        Float::INFINITY
      else
        v.to_f
      end
    }
    end
    return list
  end
  end
end