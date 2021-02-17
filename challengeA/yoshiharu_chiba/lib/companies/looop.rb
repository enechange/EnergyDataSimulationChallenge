# frozen_string_literal: true

class Looop
  def initialize(amps, amount_per_month)
    @amps = amps
    @amount_per_month = amount_per_month
  end

  def looop_plan
    (@amount_per_month * 26.40).floor
  end
end
