class Dataset < ApplicationRecord
  belongs_to :house_datum, class_name: "HouseDatum", foreign_key: "id"
end
