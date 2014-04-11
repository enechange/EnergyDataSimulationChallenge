# Julio Suarez - jcsuarez@uchicago.edu
# ph: + 44 (0) 75 270 31 737
# Visualization of Energy Consumptions
# Consumption data from 18-Apr to 24-May of 2011 in 30-minute time windows
# 
# CODE LANGUAGE: R
# BEFORE RUNNING THE CODE, PLEASE UPLOAD ENCLOSED DATABASE "total_watt2.csv"



library(ggplot2)
library(quantreg)
library(SparseM)
library(gridExtra)


# Graph of rough data
# Reads a modified file that accounts for missing data. The file is attached and is called total_watt2.csv

watt<- read.csv("total_watt2.csv")

# Generates a timeseries value
watt$ti<-1:length(watt$Time)

# Base for histogram on the right
m<-ggplot(watt, aes(x = Data))

# Base for main time-series plot
m2 <- ggplot(watt, aes(ti, Data)) + geom_point()

# Quantiles for main plot usage
q10 <- seq(0.05, 0.95, by=0.05)

# Main plot is saved as CENTER:
center<- m2 + stat_quantile(aes(colour = ..quantile..), quantiles = q10) + scale_x_continuous(breaks=c(0,311,599,887, 1223, 1511, 1703), labels=c("18/04/2011", "25/04/2011" , "01/05/2011", "07/05/2011" , "14/05/2011" , "20/05/2011", "24/05/2011")) + 
labs(title = "Energy Consumption (18-Apr to 24-May of 2011)", x = "", y = "Energy consumed (W)")

# Histogram that joins on the right the plot
right<- m + geom_histogram(aes(fill = ..density..), binwidth = 50) + geom_vline(aes(xintercept=mean(Data, na.rm=T)), color="red", linetype="dashed", size=1) +
geom_vline(aes(xintercept=median(Data, na.rm=T)), color="black", linetype="dashed", size=1)  + coord_trans(x = "sqrt") + scale_x_continuous(breaks = c(0, 500, 1000,2500,5000,7500)) +
 labs(title = "Histogram", x= "", y = "Frequency (of 1601 observations)") +
geom_text(data = NULL, x = 6000, y = 100, label = "Mean: 509.8", color="red") + geom_text(data = NULL, x = 5000, y = 110, label = "Median: 312.1") +coord_flip()


# Prints both graphs
grid.arrange(center, right, ncol=2, nrow=1, widths=c(4, 1.5), heights=c(1, 4))



###################################
# Graph of aggregating data by days

# Transforms date data and aggregates data
watt$date <- as.Date(watt$Time,format='%d/%m/%Y')
WpDay<- aggregate(Data ~ date,data=watt,sum)

# Time series variable
WpDay$ti<-1:35

# Plots data
m3 <- ggplot(WpDay, aes(ti, Data))
m3 + stat_smooth() + geom_point() +  
scale_x_continuous(breaks=c(1,5,10,15, 20, 25, 30, 35), labels=c("Monday Apr-18", "Friday Apr-22" , "Wednesday Apr-27", "Monday May-2" , "Monday May-9" , "Saturday May-14", "Thursday May-19", "Tuesday May-24")) +
labs(title = "Energy Consumption per day and geometric average (18-Apr to 24-May of 2011)", x = "", y = "Energy consumed (W)")



#####################
# Graph by clusters

# Generates terciles (clusters) and renames them into categories (Low, Medium and High)
WpDay <- within(WpDay, tercile <- as.integer(cut(Data, quantile(Data, probs=0:3/3), include.lowest=TRUE)))
WpDay$category <- ifelse(WpDay$tercile == 1, "A: Low", ifelse(WpDay$tercile == 2, "B: Medium", "C: High")) 

# Generates clusters by days for graphic reasons
WpDay$day <- weekdays(as.Date(WpDay$date))

# plots both graphs: violin histogram and cluster data by days of the week
m4 <- ggplot(WpDay, aes(category, Data))
TOP<- m4 + geom_violin(aes(fill = tercile)) + geom_jitter(height = 0) + labs(title = "Energy consumption by clusters and day of the week", x = "", y = "Energy consumed (W)")

d <- ggplot(WpDay, aes(x = category, y = day))
MED<- d + stat_sum(aes(group = 1)) + scale_size(range = c(3, 10)) + labs(title = "", x = "", y = "Day of the week")

grid.arrange(TOP, MED, ncol=1, nrow=2, widths=c(4, 1), heights=c(1.1, 2))


###
# Thanks for reading!