FactoryBot.define do
  factory :energy_dataset do
    label { 1 }
    house { nil }
    year { 1 }
    month { 1 }
    temperature { 1.5 }
    daylight { 1.5 }
    energy_production { 1 }
  end
end
