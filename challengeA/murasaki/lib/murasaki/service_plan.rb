require 'json'

class Murasaki::ServicePlan
  @raw_data = JSON.parse(File.read(File.expand_path('service-plans.json', __dir__)), symbolize_names: true)
  class << self
    attr_reader :raw_data

    def availables(ampere, _kwh)
      raw_data[:data].map do |service|
        {
          id: service[:id],
          name: service[:name],
          provider_name: service[:provider_name],
          plan: service[:monthly_basis].find { |b| b[:ampere] == ampere },
          monthly_tier: service[:monthly_tier]
        }
      end.reject do |service|
        service[:plan].nil?
      end
    end
  end
end
