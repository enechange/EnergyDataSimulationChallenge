class Energy < ActiveRecord::Base
    def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          # IDが登録されている場合、そのIDのレコードを呼び出す
          # IDが見つからない場合、新しく作成する
          energy = find_by(id: row["id"]) || new
          # CSVからデータを取得後セット
          energy.attributes = row.to_hash.slice(*updatable_attributes)
          # 保存
          energy.save!
        end
    end
    
    # 更新できるカラム定義
    def self.updatable_attributes
        ["label", "house", "year", "month", "temperature", "daylight", "energy_production"]
    end
end
