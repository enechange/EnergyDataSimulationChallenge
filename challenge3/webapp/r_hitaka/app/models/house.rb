class House < ApplicationRecord
  has_many :energies

  def self.import(file)
    CSV.foreach(file.path,
                headers: true,
                header_converters: ->(h) {h.try(:downcase)}
    ) do |row|
      house = find_by(id: row["id"]) || new
      house.attributes = row.to_hash.slice(*updatable_attributes)
      house.save!
    end
  end

  # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["id", "firstname", "lastname", "city", "num_of_people", "has_child"]
  end
end
