# frozen_string_literal: true

require 'csv'
require 'json'
require 'bigdecimal'

# 文字列のrangeをRangeクラスに変換する
class String
  def to_range
    split('..').then { |array| Range.new(array[0].to_i, array[1]&.to_i) }
  end
end

# 会社名、プラン名、基本料金のhash、従量課金料金のhashの情報持ったインスタンスを作るクラス
class ConpanyWithPlan
  attr_reader :company_name, :plan_name, :basic_charge, :electricity_charge

  def initialize(company_name:, plan_name:, basic_charge:, electricity_charge:)
    @company_name = company_name
    @plan_name = plan_name
    @basic_charge = basic_charge
    @electricity_charge = electricity_charge
  end
end

# Import.callでConpanyWithPlanのインスタンスを配列で返す
class ImportCsv
  @@data ||= CSV.read('data.csv', headers: true)

  def self.call
    @@data.map do |row|
      # row[0] = 会社名
      # row[1] = プラン名
      # row[2] = 基本料金
      # row[3] = 従量加算料金
      basic_charge = JSON.parse(row[2]).transform_keys!(&:to_i)
      electricity_charge = JSON.parse(row[3]).transform_keys!(&:to_range)
      ConpanyWithPlan.new(
        company_name: row[0],
        plan_name: row[1],
        basic_charge:,
        electricity_charge:
      )
    end
  end
end

# 最終的な出力を返すクラス
# 計算ロジックを内包している（このクラスでしか使わないため）
class Simulator
  class InValidAmpereError < StandardError; end
  class InValidKwhError < StandardError; end

  CONSTRUCTABLE_AMPERES = [10, 15, 20, 30, 40, 50, 60].freeze

  attr_reader :ampere, :kwh, :company_with_plans

  def initialize(ampere:, kwh:)
    @ampere = ampere
    @kwh = kwh
    @company_with_plans = ImportCsv.call
  end

  def simulator
    validate!

    company_with_plans.map do |company_with_plan|
      {
        provider_name: company_with_plan.company_name,
        plan_name: company_with_plan.plan_name,
        price: calculate(company_with_plan.basic_charge, company_with_plan.electricity_charge)
      }
    end
  rescue StandardError => e
    puts "エラーが発生しました。#{e}"
  end

  private

  def calculate(basic_charge, electricity_charge)
    return '契約不可なアンペア数のため、合計値は表示されません。' if basic_charge_price(basic_charge).nil?

    (BigDecimal(basic_charge_price(basic_charge)) + electricity_charge_price(electricity_charge)).to_i
  end

  def basic_charge_price(basic_charge)
    basic_charge[ampere]
  end

  def electricity_charge_price(electricity_charge)
    # 0の場合は計算ロジックを実行せずにreturn
    return 0 if kwh.zero?

    total = BigDecimal('0')

    electricity_charge.each do |range, unit_price|
      if range.include?(kwh)
        total += ((range.first..kwh).size * BigDecimal(unit_price))

        break
      end

      total += (range.size * BigDecimal(unit_price))
    end

    total.to_i
  end

  def validate!
    raise InValidAmpereError unless CONSTRUCTABLE_AMPERES.include?(ampere)
    raise InValidKwhError if !kwh.is_a?(Integer) || (kwh != 0 && !kwh.positive?)
  end
end
