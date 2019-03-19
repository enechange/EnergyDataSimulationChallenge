class Energy < ApplicationRecord
  belongs_to :house

  scope :time_series, -> { order(:year).order(:month) }

  def year_month
    "#{year}-#{month}"
  end
end
