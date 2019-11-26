FactoryBot.define do
  factory :energy_detail do
    label             { 1 }
    year              { 2011 }
    month             { 7 }
    temperature       { 25.7 }
    daylight          { 145.6 }
    energy_production { 500 }
    house
  end
end