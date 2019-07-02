require "json"

class Util
  class << self
    def form_ransack_params(params)
      param_org = params.deep_dup
      param_res = {}
      if param_org.instance_of?(String)
        param_org = JSON.parse(param_org)
      end
      param_org.each do |key, val|
        key = key.to_s.underscore
        if (key == 's' || key == 'sorts') && val.instance_of?(String)
          param_res[key] = val.squish.underscore
        elsif (key == 's' || key == 'sorts') && val.instance_of?(Array)
          param_res[key] = val.map{|v| v.squish.underscore }
        elsif (key == 'g' || key == 'groupings') && (val.instance_of?(Hash) || val.instance_of?(Array))
          if val.instance_of?(Hash)
            param_res[key] = val.values.map{|v| Util.form_ransack_params(v) }
          else
            param_res[key] = val.map{|v| Util.form_ransack_params(v) }
          end
        else
          param_res[key] = val
        end
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
      mask_list.reduce(0) do |result, mask|
        result |= mask.is_a?(String) ? mask.to_i(2) : mask.to_i
      end
    end

    def auth_user_graphql(user)
      return true if Rails.env.development?
      if user.blank? || !user.admin?
        raise GraphQL::ExecutionError.new("GraphQL: Need admin user")
      end
    end
  end
end
