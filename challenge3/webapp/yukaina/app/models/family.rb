class Family < ApplicationRecord
  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :num_of_people
  end
  validates :num_of_people, numericality: true
  validates :has_child, inclusion: { in: [true, false] }
end
