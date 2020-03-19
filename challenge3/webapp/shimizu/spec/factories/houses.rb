FactoryBot.define do
  factory :house_1, class: "House" do
    id { 101 }
    first_name { "Yuta" }
    last_name { "Shimizu" }
    city { "London" }
    num_of_people { 1 }
    has_child { false }
  end

  factory :house_2, class: "House" do
    id { 102 }
    first_name { "Ichiro" }
    last_name { "Suzuki" }
    city { "London" }
    num_of_people { 1 }
    has_child { false }
  end
end
