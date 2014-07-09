class Array
  def mean
    inject(0.0) { |sum, i| sum += i } / size
  end
end

module Analysis
  def regression(xs, ys)
    raise "arguments for regression is invalid" unless xs.length == ys.length

    beta = (xs.zip(ys).map{|i| i[0]*i[1]}.sum-xs.length*xs.mean*ys.mean) / (xs.map{|i| (i-xs.mean)**2}.sum)
    alpha = ys.mean - beta * xs.mean
    {:alpha => alpha, :beta => beta}
  end
  
  module_function :regression
end
