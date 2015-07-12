# # # # # # # # # # # # # # # # # # # #
# EnergyDataSimulationChallenge       #
# challenge2                          #
# author: Kiyotaka Mori               #
# E-Mail: kiyotaka.forest@gmail.com   #
# Lang: R version 3.2.1 (2015-06-18)  #
# Editor: Rstudio Version 0.98.1103   #
# # # # # # # # # # # # # # # # # # # #

# Read the data from csv
data <- read.csv("total_watt.csv", header=F)
colnames(data) <- c("time_stamp", "energy_consumption")
date <- as.POSIXlt(data$time_stamp)
data <- data.frame(date, data$energy_consumption)
colnames(data) <- c("time_stamp", "energy_consumption")

# If you don't install those loading packages, you type it
# install.packages(c("ggplot2", "dplyr"))

# Visualise the data-set
library(ggplot2)
vis1 <- ggplot(data, aes(x = data$time_stamp, y = data$energy_consumption, group = 1)) + geom_line() + 
xlab("time stamp") + ylab("energy consumption") + ggtitle("Visualise the data-set")

plot(vis1)

# Visualise the data-set as values per day
library(dplyr)
date <- format(data$time_stamp, "%m/%d")
time <- format(data$time_stamp, "%H:%M:%S")
hour <- as.numeric(format(data$time_stamp, "%H"))
data_divide <- data.frame(date, time, hour, data$energy_consumption)
colnames(data_divide) <- c("date", "time", "hour", "energy_consumption")

data_divide <- data_divide %>% 
  mutate(timezone = ifelse(hour < 6, "late-night", 
                           ifelse(hour < 12, "morning", 
                                  ifelse(hour < 18, "afternoon", 
                                         ifelse(hour < 24, "night", "other")
                                        )
                                  )
                           )
         )
data_perday <- data_divide %>% group_by(date, timezone) %>% summarise(sum=sum(energy_consumption))

vis2 <- ggplot(data_perday, aes(x = data_perday$date, y = data_perday$sum, fill=timezone)) + geom_bar(stat = "identity") + 
  xlab("date") + ylab("energy consumption") + ggtitle("Visualise the data-set as values per day")

plot(vis2)

#Cluster the values per day into 3 groups: low, medium, and high energy consumption

data_perday2 <- data_divide %>% group_by(date) %>% summarise(sum_all=sum(energy_consumption))

#> sum(data_perday2$sum_all<10000)
#[1] 1
#> sum(data_perday2$sum_all<20000)
#[1] 19
#> sum(data_perday2$sum_all<30000)
#[1] 27
#> sum(data_perday2$sum_all<40000)
#[1] 29
#> sum(data_perday2$sum_all<50000)
#[1] 32
#> sum(data_perday2$sum_all<60000)
#[1] 34
#> sum(data_perday2$sum_all<70000)
#[1] 35
# So, make three cluster, low(energy consumption<20000), 
# middle(20000<=energy consumption<40000) and high(40000<=energy consumption).

data_perday2 <- data_perday2 %>% mutate(cluster = ifelse(sum_all < 20000, 1, 
                                                       ifelse(40000 < sum_all, 3, 2)
                                                       )
                                      )

# Visualise the clusters
cluster_high <- data_perday %>% inner_join(data_perday2, by="date") %>% filter(cluster == 3) %>% 
  group_by(timezone) %>% summarise(sum=sum(sum))
cluster_middle <- data_perday %>% inner_join(data_perday2, by="date") %>% filter(cluster == 2) %>% 
  group_by(timezone) %>% summarise(sum=sum(sum))
cluster_low <- data_perday %>% inner_join(data_perday2, by="date") %>% filter(cluster == 1) %>% 
  group_by(timezone) %>% summarise(sum=sum(sum))


vis3_1 <- ggplot(cluster_high, aes(x = "", y = sum, fill = timezone)) + geom_bar(width=1, stat="identity") + 
  coord_polar(theta = "y") + ggtitle("Visualise the cluster high energy consumption")
plot(vis3_1)

vis3_2 <- ggplot(cluster_middle, aes(x = "", y = sum, fill = timezone)) + geom_bar(width=1, stat="identity") + 
  coord_polar(theta = "y") + ggtitle("Visualise the cluster middle energy consumption")
plot(vis3_2)

vis3_3 <- ggplot(cluster_low, aes(x = "", y = sum, fill = timezone)) + geom_bar(width=1, stat="identity") + 
  coord_polar(theta = "y") + ggtitle("Visualise the cluster low energy consumption")
plot(vis3_3)
