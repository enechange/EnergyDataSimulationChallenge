class House < ActiveRecord::Base
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          # IDが登録されている場合、そのIDのレコードを呼び出す
          # IDが見つからない場合、新しく作成する
          house = find_by(id: row["id"]) || new
          # CSVからデータを取得後セット
          house.attributes = row.to_hash.slice(*updatable_attributes)
          # 保存
          house.save!
        end
    end
    
    # 更新できるカラム定義
    def self.updatable_attributes
        ["first_name", "last_name", "city", "num_of_people", "has_child"]
    end
end
