FactoryBot.define do
  factory :energy_dataset_1, class: "EnergyDataset" do
    label { 1 }
    house_id { 101 }
    year { 2020 }
    month { 1 }
    temperature { 20 }
    daylight { 200 }
    energy_production { 700 }

    association :house, factory: :house_1
  end

  factory :energy_dataset_2, class: "EnergyDataset" do
    label { 1 }
    house_id { 102 }
    year { 2020 }
    month { 1 }
    temperature { 25 }
    daylight { 250 }
    energy_production { 800 }

    association :house, factory: :house_2
  end
end
