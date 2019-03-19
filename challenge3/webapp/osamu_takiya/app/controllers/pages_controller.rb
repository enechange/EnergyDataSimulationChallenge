class PagesController < ApplicationController
  def index
    @energy_production_per_month_whether_has_child_or_not = energy_production_per_month_whether_has_child_or_not

    # TODO: ハードコーディングをやめる（データベースから持ってくる）
    @energy_production_in_cities_in_years = energy_production_per_year_in_each_city(
      target_years_range: 2011..2013,
      target_cities: %w(Oxford Cambridge London)
    )
  end

  private

  def energy_production_per_month_whether_has_child_or_not
    energy_production_per_month_with_child    = HouseDataset.energy_production_whether_has_child_or_not(1, :month)
    energy_production_per_month_without_child = HouseDataset.energy_production_whether_has_child_or_not(0, :month)

    [
      { name: '子供あり', data: energy_production_per_month_with_child },
      { name: '子供なし', data: energy_production_per_month_without_child },
    ]
  end

  # 戻り値の例: { "2011"=>{"Oxford"=>30985, "Cambridge"=>37528, "London"=>104348}, "2012"=>{"Oxford"=>66529, "Cambridge"=>80867, "London"=>224915},...
  def energy_production_per_year_in_each_city(target_years_range:, target_cities:)
    # HACK: ネストが臭う
    energy_production_in_cities_in_years = {}

    target_years_range.each do |target_year|
      hash_in_hash = {}

      target_cities.each do |target_city|
        hash_in_hash[target_city] = HouseDataset.energy_production_in_each_city(
          target_city,
          target_year
        )
                                                .values[0] # TODO: ハードコーディングすぎる
      end

      energy_production_in_cities_in_years[target_year.to_s] = hash_in_hash
    end

    energy_production_in_cities_in_years
  end
end
