class EnergyForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :label, :integer
  attribute :house_id, :integer
  attribute :year, :integer
  attribute :month, :integer
  attribute :temperature, :decimal
  attribute :daylight, :decimal
  attribute :energy_production, :integer

  validates :label, presence: true
  validates :house_id, presence: true
  validates :year, presence: true
  validates :month, presence: true
  validates :temperature, presence: true
  validates :daylight, presence: true
  validates :energy_production, presence: true

  def save
    energy.save!
  end

  def energy
    @energy ||= Energy.new(as_json)
  end

  private

  def as_json
    {
      label: label,
      house_id: house_id,
      year: year,
      month: month,
      temperature: temperature,
      daylight: daylight,
      energy_production: energy_production
    }
  end
end
