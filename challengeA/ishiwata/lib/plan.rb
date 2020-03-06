class Plan

  attr_reader :provider_name, :plan_name

  def initialize(args)
    @provider_name = args[:provider_name]
    @plan_name = args[:plan_name]
  end

end
