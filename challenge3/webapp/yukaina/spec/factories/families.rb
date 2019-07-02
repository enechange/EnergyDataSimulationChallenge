FactoryBot.define do
  factory :family do
    first_name { "none" }
    last_name { "none" }
    num_of_people { 1 }
    has_child { false }
  end
end
