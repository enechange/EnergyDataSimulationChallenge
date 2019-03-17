# frozen_string_literal: true

class House < ApplicationRecord
  belongs_to :city
  # NOTE: 日照量と発電量など単体でも有益の可能性があるので dependent: :nullify
  has_many :monthly_house_energy_productions, dependent: :nullify

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :num_of_people, presence: true, numericality: { greater_than: 0, only_integer: true}
  validates :has_child, inclusion: { in: [true, false] }
end
