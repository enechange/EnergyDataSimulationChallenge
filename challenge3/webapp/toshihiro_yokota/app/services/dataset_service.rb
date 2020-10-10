class DatasetService
  private_class_method :new

  def self.call(dataset)
    new.call(dataset)
  end

  def call(dataset)
    dataset.each do |row|
      energy_form = EnergyForm.new(energy_form_params(row))
      energy_form.save
    end
  end

  private

  def energy_form_params(row)
    {
      label: row['Label'],
      house_id: row['House'],
      year: row['Year'],
      month: row['Month'],
      temperature: row['Temperature'],
      daylight: row['Daylight'],
      energy_production: row['EnergyProduction']
    }
  end
end
