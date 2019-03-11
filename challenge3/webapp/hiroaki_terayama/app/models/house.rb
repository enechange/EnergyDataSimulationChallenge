class House < ApplicationRecord
  enum has_child: { Yes: true, No: false }

  has_many :energy_records

  validates :origin_id, presence: true, uniqueness: true, numericality: { only_integer: true }
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city, presence: true
  validates :num_of_people, presence: true, numericality: { only_integer: true }
  validates :has_child, presence: true

  def self.get_attributes(row)
    {
        origin_id: row['ID'].to_i,
        firstname: row['Firstname'],
        lastname: row['Lastname'],
        city: row['City'],
        num_of_people: row['num_of_people'].to_i,
        has_child: row['has_child']
    }
  end
end
