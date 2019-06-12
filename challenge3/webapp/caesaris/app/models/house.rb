class House < ApplicationRecord
  has_many :datasets
  belongs_to :city, optional: true
  validates_presence_of :firstname, :lastname, :city_text, :num_of_people, :has_child

  enum has_child: {
    Yes: true,
    No: false,
  }
end

# Columns:
# firstname, lastname, city_text, city_id, num_of_people, has_child
