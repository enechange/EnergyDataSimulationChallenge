class House < ApplicationRecord
  include PluckToHash

  CITIES     = %w[London Cambridge Oxford].freeze
  PLUCK_KEYS = %i[id firstname lastname city num_of_people has_child].freeze

  has_many :energies

  validates :firstname, :lastname, :city, :num_of_people, presence: true
  validates :city,      inclusion: { in: CITIES }
  validates :has_child, inclusion: { in: [true, false] }

  scope :with_energies,          -> { includes(:energies) }
  scope :group_by_city,          -> (city_name) { group(city_name) }
  scope :by_city,                -> (city_name) { where(city: city_name) }
  scope :count_children_by_city, -> (city_name) { by_city(city_name).group(:has_child).count }

  class << self
    def csv_header_converters
      -> (name) {
        {
          ID:            :id,
          Firstname:     :firstname,
          Lastname:      :lastname,
          City:          :city,
          num_of_people: :num_of_people,
          has_child:     :has_child
        }[name.to_sym] || raise
      }
    end

    def csv_converters
      lambda { |field, field_info|
        if field_info.header == :has_child
          field == 'Yes'
        else
          field
        end
      }
    end

    def target_cities
      pluck(:city).uniq
    end

    def children_by_city
      CITIES.map do |city_name|
        {
          name: city_name,
          data: count_children_by_city(city_name)
        }
      end
    end
  end
end
