class Highchart::IndexForm
  TRACKS = [:track_from, :track_to].freeze

  attr_reader :params

  def initialize(params)
    @params = params
  end

  def city
    @city ||= (params[:city] || "")
  end

  def cap_city
    @cap_city ||= city.capitalize
  end

  def num_of_people
    @num_of_people ||= params[:num_of_people].to_i
  end

  TRACKS.each do |k|
    define_method k do
      return if params[k].blank?
      ivar_key = "@#{k}".to_sym
      instance_variable_get(ivar_key) || instance_variable_set(ivar_key, Time.zone.parse("#{params[k]}01"))
    end
  end

  def in_time?(collect_date)
    return false if track_from && track_from > collect_date
    return false if track_to && track_to < collect_date
    true
  end
end
