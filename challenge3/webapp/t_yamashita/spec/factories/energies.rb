FactoryBot.define do
  factory :energy do
    user_id              {1}
    year                 {2013}
    month                {1}
    temperature          {25.80}
    daylight             {190.50}
    energy_production    {439}
  end
end
