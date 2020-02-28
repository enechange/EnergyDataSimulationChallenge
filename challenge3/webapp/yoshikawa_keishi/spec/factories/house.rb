FactoryBot.define do

  factory :house do
    csv_id               {1}
    firstname            {"tom"}
    lastname             {"brown"}
    city                 {"London"}
    num_of_people        {2}
    has_child            {1}
  end

end