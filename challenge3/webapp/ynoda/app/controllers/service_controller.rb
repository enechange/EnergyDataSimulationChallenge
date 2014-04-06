class ServiceController < ApplicationController
  protect_from_forgery
  def listhouses
	@houses = House.all
	render :json => @houses
  end

  def listenergylogs
	@energylogs = Energylog.all
	render :json => @energylogs
  end

  def listjoineddata
        @all = Energylog.joins(:house).
	     order('energylogs.id').
	     select('energylogs.*, houses.firstname, houses.lastname')
        render :json => @all
  end

  def getAvgEPByCity
	@result = []
	data = []
	cities = House.all.group(:city).select(:city)
	cities.each do |cityobj|
		avgarg = []
		timelabels = []
		i = 1
		energyavgs = Energylog.joins(:house).
		      order('energylogs.year, energylogs.month').
	      	      group(:city, :year, :month).
	      	      select('energylogs.year, energylogs.month, avg(energyproduction) as average').
		      where('houses.city = ?', cityobj.city)
		energyavgs.each do |d|
		      avgarg.push(d.average)
		      timelabels.push({"value" => i, "text" => d.year.to_s + "-" + d.month.to_s})
		      i += 1
		end
		@result.push({"city" => cityobj.city, "avgs" => avgarg, "timelabels" => timelabels})
	end
	render :json => @result
  end
  
  def getEPByFamily
	@result = Energylog.joins(:house).
		select('houses.has_child, energylogs.templature as x, energylogs.energyproduction as y')
	render :json => @result
  end

end
