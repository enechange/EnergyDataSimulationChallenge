module ApplicationHelper

  def total_title(index)
    index.zero? ? "月別エネルギー生産量" : "月別日光量"
  end

  def average_title(index)
    case index
    when 0
      "月別平均エネルギー生産量"
    when 1
      "月別平均日光量"
    when 2
      "月別平均温度"
    end
  end

  def total_ytitle(index)
    index.zero? ? "エネルギー生産量" : "日光量"
  end

  def average_ytitle(index)
    case index
    when 0
      "平均エネルギー生産量"
    when 1
      "平均日光量"
    when 2
      "平均温度"
    end
  end
end
