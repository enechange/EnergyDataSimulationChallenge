class HouseDataCsvConverter
  def self.headers
    # ID,Firstname,Lastname,City,num_of_people,has_child
    ->(header) {
      {
        "ID" => :id,
        "Firstname" => :first_name,
        "Lastname" => :last_name,
        "City" => :city_name,
        "num_of_people" => :num_of_people,
        "has_child" => :has_child,
      }[header]
    }
  end

  def self.fields
    ->(field, field_info) {
      # has_child の 'Yes', 'No' を true, false に変換
      return field == "Yes" if field_info[:header] == :has_child

      field
    }
  end
end
