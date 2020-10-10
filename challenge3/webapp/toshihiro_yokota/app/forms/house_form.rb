class HouseForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :firstname, :string
  attribute :lastname, :string
  attribute :city_id, :integer
  attribute :num_of_people, :integer, default: 0
  attribute :has_child, :boolean, default: false

  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :city_id, presence: true
  validates :num_of_people, presence: true
  validates :has_child, presence: true

  def save
    ActiveRecord::Base.transaction do
      house.save!
    end
  end

  def house
    @house ||= House.new(as_json)
  end

  private

  def as_json
    {
      firstname: firstname,
      lastname: lastname,
      city_id: city_id,
      num_of_people: num_of_people,
      has_child: has_child
    }
  end
end
