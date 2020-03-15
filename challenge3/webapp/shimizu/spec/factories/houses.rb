FactoryBot.define do
  factory :house do
    first_name { "MyString" }
    last_name { "MyString" }
    city { "MyString" }
    num_of_people { 1 }
    has_child { false }
  end
end
