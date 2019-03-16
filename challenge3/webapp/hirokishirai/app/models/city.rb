class City < ApplicationRecord
  # NOTE: 世帯情報など単体でも有益の可能性があるので dependent: :nullify
  has_many :houses, dependent: :nullify

  validates :name, presence: true, inclusion: %w(London Cambridge Oxford)
end
