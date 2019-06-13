require "json"

class Util
  class << self
    def form_ransack_params(params)
      param_org = params
      param_res = {}
      if param_org.instance_of?(String)
        param_org = JSON.parse(param_org)
      end
      param_org.each do |key, val|
        key = key.to_s.underscore
        param_res[key] = val
      end
      param_res
    end
  end
end
