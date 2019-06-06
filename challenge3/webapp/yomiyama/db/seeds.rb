require 'csv'

def to_boolean(string)
  case string
  when 'Yes'
    true
  when 'No'
    false
  end
end

