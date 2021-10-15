# frozen_string_literal: true

require 'yaml'
require_relative 'provider'

# プロバイダーのデータの読み込み
PROVIDERS = open('./providers.yaml', 'r') { |f| YAML.safe_load(f) }

# シミュレータークラス
class Simulator
  # クラスインスタンス変数@providersの定義
  @providers = []
  class << self
    attr_reader :providers
  end

  PROVIDERS.each do |provider_name, plans|
    @providers << Provider.new(provider_name, plans)
  end

  # @conditions：ユーザー側の条件（hash）
  # 例：{ amp: 10, kwh: 100 }（契約アンペア数[A]が10，使用量[kWh]が100の場合）
  def initialize(amp, kwh)
    @conditions = { amp: amp, kwh: kwh }
  end

  # 契約アンペア数，使用量から，各プランについて料金を計算し，
  # { provider_name: プロバイダー名, plan_name: プラン名, price: 料金 }の形式のhashを要素とする配列として返す
  def simulate
    results = []
    self.class.providers.each do |provider|
      provider.plans.each do |plan|
        price = plan.price(@conditions)
        # 料金が計算できないプランについては，配列に含めない
        results << { provider_name: provider.name, plan_name: plan.name, price: price } unless price.nan?
      end
    end
    results
  end
end
