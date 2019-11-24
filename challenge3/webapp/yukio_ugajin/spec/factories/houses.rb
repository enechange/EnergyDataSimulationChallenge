FactoryBot.define do
  factory :house do
    firstname     { 'Yukio' }
    lastname      { 'Ugajin' }
    city          { 0 }
    num_of_people { 3 }
    has_child     { true }
  end
end
