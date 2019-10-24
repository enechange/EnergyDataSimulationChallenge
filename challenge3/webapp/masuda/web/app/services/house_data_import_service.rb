class HouseDataImportService
  def initialize(csv_row:)
    @csv_row = csv_row
  end

  def call
    ActiveRecord::Base.transaction do
      House.find_or_create_by!(
        id: @csv_row[:id],
        firstname: @csv_row[:firstname],
        lastname: @csv_row[:lastname],
        city: @csv_row[:city],
        num_of_people: @csv_row[:num_of_people],
        has_child: @csv_row[:has_child],
      )
    end
  end
end
