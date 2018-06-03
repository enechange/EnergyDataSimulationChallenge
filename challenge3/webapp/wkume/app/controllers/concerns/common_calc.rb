module CommonCalc
  extend ActiveSupport::Concern

  def ave_calc(array)
    array.inject(0.0){|r,i| r+=i }/array.size
  end
end