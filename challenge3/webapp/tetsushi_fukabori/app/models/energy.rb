class Energy < ApplicationRecord
  belongs_to :house

  validates :label,
            presence: true,
            numericality: { only_integer: true }
  validates :year,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :month,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }
  validates :temperature,
            presence: true,
            numericality: true
  validates :daylight,
            presence: true,
            numericality: true
  validates :production,
            presence: true,
            numericality: true

  SCATTER_KEY_LIST = %w[date city num_of_people has_child].freeze
  LINE_KEY_LIST = %w[city num_of_people has_child].freeze

  def self.scatter_data(key = nil)
    result = []
    data = joins(:house)
             .select("
               CONCAT(year, '-', LPAD(month, 2, '0')) AS date,
               city,
               num_of_people,
               has_child,
               daylight,
               production")
    data.each do |dat|
      label = SCATTER_KEY_LIST.include?(key) ? dat.send(key.to_sym) : 'all'
      label = House.cities.invert[label].capitalize if key == 'city'
      label = (label == 1 ? 'Yes' : 'No') if key == 'has_child'
      dataset = result.find { |item| item[:label] == label }
      if dataset.present?
        dataset[:data] << { x: dat.daylight, y: dat.production }
      else
        result << { label: label, data: [{ x: dat.daylight, y: dat.production }] }
      end
    end
    result
  end

  def self.line_data(key = nil)
    result = []
    date_axis = []
    grouping_key = LINE_KEY_LIST.include?(key) ? key.to_s : "\'all\'"
    selection = "CONCAT(year, '-', LPAD(month, 2, '0')) AS date, #{grouping_key} AS grouping_key, AVG(production) AS production"
    grouping = "date, #{grouping_key}"

    data = joins(:house).select(selection).group(grouping).order('date')
    prev_date = ''
    data.each do |dat|
      label = dat.grouping_key
      label = House.cities.invert[label].capitalize if key == 'city'
      label = (label == 1 ? 'Yes' : 'No') if key == 'has_child'

      if prev_date != dat.date
        date_axis << dat.date
        prev_date = dat.date
      end

      dataset = result.find { |item| item[:label] == label }
      if dataset.present?
        dataset[:data] << dat.production
      else
        result << { label: label, data: [dat.production] }
      end
    end
    { labels: date_axis, datasets: result }
  end
end
