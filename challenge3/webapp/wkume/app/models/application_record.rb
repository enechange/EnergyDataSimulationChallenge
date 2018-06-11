class ApplicationRecord < ActiveRecord::Base
  require 'csv'
  self.abstract_class = true
  
  def self.simple_import(path: '', col_sep: ',')
    a = []
    CSV.foreach(path, headers: true, col_sep: col_sep) do |r|
      a << self.new(get_import_params(r))
    end
    import a # activerecord-importのメソッドです。
  end

  private
    def self.get_import_params(row)
      headers = row.headers & self.column_names # 存在するカラム名のみに限定する
      headers.each_with_object({}) do |c, h|
        h[c.to_sym] = row.field(c)
      end
    end
end
