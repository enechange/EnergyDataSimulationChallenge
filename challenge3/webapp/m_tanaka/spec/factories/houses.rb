FactoryBot.define do
  factory :house do
    first_name { 'test' }
    last_name { 'name' }
    city { 'London' }
    num_of_people { 2 }
    has_child { 3 }
  end
end