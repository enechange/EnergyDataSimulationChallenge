class Simulator
  include ActiveModel::Model

  attr_accessor :current, :power
  def simulate
    plans = Plan.all.includes(:provider)
    plans.each do |plan|
    end
  end
end
