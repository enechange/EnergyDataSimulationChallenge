FactoryBot.define do

  factory :datum do
    association :house
    csv_id             {1}
    label              {1}
    year               {2012}
    month              {1}
    temperature        {10}
    daylight           {10}
    energy_production  {100}
  end

end