class RatePlanSchemaParser

  def self.parse!
    parser = self.new
    parser.parse!
  end

  def parse!
    plans = []
    parsed_schema.each_pair do |plan_name, detail|
      plans << Plan.new(
        name:              plan_name,
        day_time:          detail['Day time'],
        night_time:        detail['Night time'],
        night_time_range:  detail['Night time range'],
      )
    end
    plans
  end

  private

  def parsed_schema
    JSON.parse(File.read(Rails.root.join('data', 'plans.json')))
  end
end
