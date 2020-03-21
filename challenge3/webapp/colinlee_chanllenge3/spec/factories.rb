require 'factory_bot'
require 'ffaker'

FactoryBot.define do
  factory :house do
    first_name   { FFaker::Name.first_name }
    last_name    { FFaker::Name.last_name }
    city         { FFaker::Address.city }
    living_count { FFaker::Random.rand(0..9) }

    trait :with_children do
      has_chile { true }
    end
  end

  factory :energy_consume do
    label             { FFaker::Random.rand(0..9) }
    year              { FFaker::Random.rand(2000..2020) }
    month             { FFaker::Random.rand(1..12) }
    energy_production { FFaker::Random.rand(100..900) }
    house
  end
end
