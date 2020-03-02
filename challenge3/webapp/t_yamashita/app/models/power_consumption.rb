class PowerConsumption < ApplicationRecord
  # associations
  belongs_to :user

  # validations
  validates :user_id,
            :year,
            :month,
            :power_consumption, presence: true

  # model methods
  def self.total_power(user)
    array = []
    powers = PowerConsumption.where(user_id: user)
    powers.each do |e|
      array << e.power_consumption
    end

    return array.inject(:+)
  end
end
