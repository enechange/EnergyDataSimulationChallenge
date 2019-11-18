class Energy < ApplicationRecord
  belongs_to :house
  
  def self.count_year(id)
    @house = where(house_id: id)
    @years = @house.group('year').select('year')
  end
  
  def self.get_data(id, years)
    @house = where(house_id: id)
    @target_dates = []
    years.each do |y|
      @house.each do |d|
        if y.year == d.year
          @target_dates << [d.year, d.month, d.daylight, d.energy_production]
        end
      end
    end
    @target_dates
  end
end
