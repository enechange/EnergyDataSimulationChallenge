class HouseDatum < ApplicationRecord
	def self.import(file)
		table = CSV.table(file.path, headers: true)
		table.each do |row|
			# IDが見つかれば、レコードを呼び出し、見つかれなければ、新しく作成
			data = find_by(id: row[:id]) || new
			# CSVからデータを取得し、設定する
			data.attributes = row.to_h.map{|k,v| [k.to_s, v] }.to_h.slice(*updatable_attributes)
			# 保存する
			data.save
		end
	end

	# 更新を許可するカラムを定義
  def self.updatable_attributes
    ["firstname", "lastname", "city", "num_of_people", "has_child"]
	end
end
