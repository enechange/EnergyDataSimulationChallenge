class House < ApplicationRecord

  has_many :energies

  CITIES = %w(London Cambridge Oxford)

  validates :firstname, :lastname, :city, :num_of_people, presence: true
  validates :city, inclusion: { in: CITIES, allow_blank: true }
  validates :has_child, inclusion: { in: [true, false] }

  class << self
    def csv_header_converters
      lambda do |name|
        {
            ID:            :id,
            Firstname:     :firstname,
            Lastname:      :lastname,
            City:          :city,
            num_of_people: :num_of_people,
            has_child:     :has_child
        }[name.intern] || raise
      end
    end

    def csv_converters
      lambda do |field, field_info|
        if field_info.header == :has_child
          field == 'Yes' ? true : false
        else
          field
        end
      end
    end
  end

end
