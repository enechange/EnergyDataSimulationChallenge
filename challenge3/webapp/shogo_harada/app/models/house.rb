class House < ApplicationRecord
  has_many  :energy_usages, dependent: :destroy

  validates :firstname,     presence: true
  validates :lastname,      presence: true
  validates :city,          presence: true, inclusion: { in: %w(London Cambridge Oxford) }
  validates :num_of_people, presence: true
  validates :has_child,     inclusion: { in: [true, false] }

  def has_child?
    has_child ? 'Yes' : 'No'
  end
end
