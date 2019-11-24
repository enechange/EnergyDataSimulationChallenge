class House < ApplicationRecord

  CITIES     = %w[London Cambridge Oxford].freeze

  has_many :energies

  validates :firstname, :lastname, :city, :num_of_people, presence: true
  validates :city, inclusion: { in: CITIES }
  validates :has_child, inclusion: { in: [true, false] }

  class << self
    def csv_header_converters
      lambda { |name|
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
  end
end
