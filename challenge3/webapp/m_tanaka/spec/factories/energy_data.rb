FactoryBot.define do
  factory :energy_datum do
    label { 0 }
    house
    year { 2011 }
    month { 7 }
    temperature { 30 }
    daylight { 180 }
    energy_production { 1100 }
  end
end