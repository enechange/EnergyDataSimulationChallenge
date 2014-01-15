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

# exploration ---------------------------
ggplot(total_watt) + geom_point(aes(x = time, y = energy))
# conclusion: there's a gap, otherwise quite unenlightening

durations_temp <- as.duration(interval(total_watt$time[-length(total_watt$time)], total_watt$time[-1]))
summary(durations_temp)
durations_temp[durations_temp!=1800,]
# conclusion: vast majority of readings are half hourly

ggplot(total_watt) + stat_density(aes(x = energy),xlim=c(0,1500)) + xlim(0, 1500)
# conclusion: surprisingly unsmooth for 1600 readings
