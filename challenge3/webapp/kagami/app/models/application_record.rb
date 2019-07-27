class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def self.simple_import(path: '', col_sep: ',')
    a = []
    CSV.foreach(path, headers: true, col_sep: col_sep) do |r|
      a << self.new(get_import_params(r))
    end
    import a
  end

private
  def self.get_import_params(row)
    headers = row.headers & self.column_names
    headers.each_with_object({}) do |c, h|
      h[c.to_sym] = row.field(c)
    end
  end
end
