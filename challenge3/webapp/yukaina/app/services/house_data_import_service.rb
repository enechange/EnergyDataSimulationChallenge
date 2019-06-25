class HouseDataImportService
  def initialize(csv_row:)
    @csv_row = csv_row
  end

  def call
    ActiveRecord::Base.transaction do
      city = City.find_or_create_by!(name: @csv_row[:city_name])
      # "同姓&同名&同じ家族構成"がいると使えないので、id も固定して渡す。
      family = Family.find_or_create_by!(@csv_row.to_h.slice(:id, :first_name, :last_name, :num_of_people, :has_child))
      House.create!(id: @csv_row[:id], city: city, family: family)
    end
  end
end
