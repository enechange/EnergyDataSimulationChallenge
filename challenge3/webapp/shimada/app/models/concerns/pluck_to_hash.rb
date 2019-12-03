module PluckToHash
  extend ActiveSupport::Concern

  # pluckで取得した配列を定義したカラム名でHash化
  class_methods do
    def pluck_to_hash(pluck_keys)
      pluck(*pluck_keys).map do |column_value|
        pluck_keys.zip(column_value).to_h
      end
    end
  end
end
