class HouseDataService
  private_class_method :new

  def self.call(house_data)
    new.call(house_data)
  end

  def call(house_data)
    house_data.each do |row|
      city = City.find_or_create_by!(name: row['City'])
      house_form = HouseForm.new(house_form_params(row, city))
      house_form.save
    end
  end

  private

  def house_form_params(row, city)
    {
      id: row['ID'],
      firstname: row['Firstname'],
      lastname: row['Lastname'],
      city_id: city.id,
      num_of_people: row['num_of_people'],
      has_child: row['has_child'] == 'Yes'
    }
  end
end
