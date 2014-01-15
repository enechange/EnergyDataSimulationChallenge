# Load libraries ---------------------------
library(lubridate)
library(ggplot2)

# Load data ---------------------------
total_watt <- read.csv("../../data/total_watt.csv", 
											 col.names = c('time','energy'), 
											 stringsAsFactors = F
)

# clean data ---------------------------
total_watt$time <- ymd_hms(total_watt$time)

# exploration and visualization ---------------------------
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



# visualize the dataset by day ---------------------------


