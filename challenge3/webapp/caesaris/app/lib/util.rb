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

    def graphql_query(query_string, raise_err = true)
      result = CaesarisSchema.execute(query_string)
      if result["errors"].present? && raise_err
        raise result["errors"][0]["message"]
      else
        result["data"]
      end
    end

    def auth_binary(code, mask)
      _code = code.is_a?(String) ? code.to_i(2) : code.to_i
      _mask = mask.is_a?(String) ? mask.to_i(2) : mask.to_i
      (_code & _mask) == _mask
    end

    def set_binary_codes(mask_list)
      mask_list.map do |mask|
        mask.is_a?(String) ? mask.to_i(2) : mask.to_i
      end.reduce(:|)
    end
  end
end
