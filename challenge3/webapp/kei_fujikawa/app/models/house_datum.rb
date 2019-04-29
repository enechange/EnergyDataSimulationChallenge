class HouseDatum < ApplicationRecord
  has_many :datasets, class_name: "Dataset", foreign_key: "house"
end
