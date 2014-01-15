# Load libraries ===========================================
library(lubridate)
library(ggplot2)
library(plyr) # dplyr is a bit more elegant, but isn't in CRAN yet 

# Load data ============================================
total_watt <- read.csv("../../data/total_watt.csv", 
											 col.names = c('time','energy'), 
											 stringsAsFactors = F
)

# clean data =====================================
total_watt$time <- ymd_hms(total_watt$time)

# exploration and visualization ==================================
ggplot(total_watt) + geom_point(aes(x = time, y = energy))
# conclusion: there's a gap, otherwise quite unenlightening

ggplot(total_watt) + geom_point(aes(x = time, y = energy)) + scale_y_log10()
# this is still quite unenlightening.

# to investigate outliers, we'll plot a kde of energy consumption
# but first we must check that each consumption reading is over the same length of time
durations_temp <- as.duration(interval(total_watt$time[-length(total_watt$time)], total_watt$time[-1]))
summary(durations_temp)
durations_temp[durations_temp!=1800,]
# conclusion: vast majority of readings are half hourly, so we're good to go on a kde.

# plot the kde:
ggplot(total_watt) + stat_density(aes(x = energy))
# those outliers look interesting. Maybe a log scale would help see what's going on?
ggplot(total_watt) + stat_density(aes(x = energy)) + scale_x_log10()
# or not, as the case may be.

# Let's think about these outliers for a second:
# are they the result of typical usage?
with(total_watt, sum(energy > 1500) / length(energy) * 24)
# so, on average, 1.125 half hour periods every day are outlying.
# the big electricty draws in a house will be heating applications: air heating, laundry, cooking
# so these outliers could plausibly be one particular application, say an oven or a tumble dryer.

# so how do we work out what the application is? aggregating over time!
ggplot(ddply(.data = total_watt, .variables = c(hour = .(hour(time))), .fun = summarise,
						 avg_energy = mean(energy))
			 ) + geom_line(aes(x = hour, y = avg_energy))
# so this is alright, we can see people cooking lunch. Variance would be nice, though
ggplot(total_watt) + stat_smooth(aes(x = hour(time), y = energy))
# much better visualization, and nicer code too.
# (the line is a loess line, the grey area is 0.95 confidence interval)

# this plot over half hour intervals:
ggplot(total_watt) + stat_smooth(aes(x = time, y = energy))
# doesn't really reveal much more. 
# Unfortunately this plot hides the period of no measurment in early May,
# but it does show that consumption drops ~50% over the unmeasured period
# before rebounding at the end of May

# visualize the dataset by day =======================================
ggplot(total_watt) + stat_smooth(aes(x = yday(time), y = energy))
# this is per day of the year. Doesn't really have any advantage over half hour intervals.

ggplot(total_watt) + stat_boxplot(aes(x = factor(yday(time)), y = energy))
# this isn't really much use, and looks pretty messy.

# clustering days ============================================
# The simplest thing to do here it to take one average reading for each day.
# More advanced stuff could involve clustering days by the distribution of usage inside that day

# first, we need to aggregate aggregate
total_watt_daily <- ddply(.data = total_watt, .variables = c(yday = .(yday(time))), .fun = summarise,
													avg_energy = mean(energy)
													)

# now let's do k-means
clusters_kmeans <- kmeans(x = total_watt_daily$avg_energy, 
													centers = 3)
# and view the results:
clusters_kmeans

# we'll assign the clusters back to the aggregated days
total_watt_daily$cluster <- clusters_kmeans$centers[clusters_kmeans$cluster]
# and see the results
ggplot(total_watt_daily[order(total_watt_daily$avg_energy),]) + geom_point(aes(x = 1:nrow(total_watt_daily), y = avg_energy, colour = factor(cluster_centre)))
# The highest energy consumption cluster does seem to be somewhat different.
# the line between the lower two seems a bit arbitrary, though
# let's see the results another way
total_watt$daily_cluster_centre <- total_watt_daily[match(yday(total_watt$time), total_watt_daily$yday),'cluster']
ggplot(total_watt) + stat_boxplot(aes(x = factor(yday(time)), y = energy, colour = factor(daily_cluster_centre)))
# this seems to show that the high values are heavily driven by outliers