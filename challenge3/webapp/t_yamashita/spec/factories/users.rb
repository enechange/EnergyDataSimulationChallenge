FactoryBot.define do
  factory :user do
    firstname               {"aaa"}
    lastname                {"bbb"}
    password                {"1a1a1a"}
    password_confirmation   {"1a1a1a"}
    email                   {"abc@example.com"}
    city_id                 {1}
  end
end