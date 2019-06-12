class House < ApplicationRecord
  enum has_child: {
    Yes: true,
    No: false,
  }
end

# Columns:
# id, firstname, lastname, city_text, city_id, num_of_people, has_child, , 
