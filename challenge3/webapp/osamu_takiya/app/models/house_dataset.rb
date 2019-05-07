class HouseDataset < ApplicationRecord
  has_many :energy_production_datasets, dependent: :destroy

  validates :firstname,
            presence: true
  validates :lastname,
            presence: true
  validates :city,
            presence: true,
            inclusion: { in: %w(London Cambridge Oxford) }
  validates :num_of_people,
            presence: true,
            numericality: { only_integer: true }
  validates :has_child,
            inclusion: { in: [true, false] }

  scope :energy_production_whether_has_child_or_not, lambda { |has_child_or_not, period_unit|
    joins(:energy_production_datasets)
      .where(has_child: has_child_or_not)
      .group(period_unit) # 「年」単位や「月」単位などの「単位」を指定する
  }

  scope :energy_production_in_each_city, lambda { |city_name, what_year|
    joins(:energy_production_datasets)
      .where(
        city: city_name,
        energy_production_datasets: { year: what_year }
      )
      .group(:year)
  }
end
