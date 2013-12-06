
# reading the data
raw.data <- read.table("../../data/training_dataset_500.csv",
                       header=T, sep=",")

head(raw.data)
# too short for a meaningful time series analysis as
# dataset doesn't even cover 2 seasons
# looking for a model EnergyProduction ~ Temperature + Daylight


# getting an overview of the data
# histograms with curve of normal distribution
# is the data Gaussian?
# motivation: model data with a Bayesian network by
# using linear Gaussian conditional densities

par(mfrow=c(2,2))
h <- hist(raw.data$Temperature, main="Temperature")
x <- seq(min(raw.data$Temperature),
         max(raw.data$Temperature), length=100) 
y <- dnorm(x, mean=mean(raw.data$Temperature),
           sd=sd(raw.data$Temperature)) 
y <- y * diff(h$mids[1:2]) * length(raw.data$Temperature) 
lines(x, y, lwd=2)

h <- hist(raw.data$Daylight, main="DayLight")
x <- seq(min(raw.data$Daylight),
         max(raw.data$Daylight), length=100) 
y <- dnorm(x, mean=mean(raw.data$Daylight),
           sd=sd(raw.data$Daylight)) 
y <- y * diff(h$mids[1:2]) * length(raw.data$Daylight) 
lines(x, y, lwd=2)

h <- hist(raw.data$EnergyProduction, main="EnergyProduction")
x <- seq(min(raw.data$EnergyProduction),
         max(raw.data$EnergyProduction), length=100) 
y <- dnorm(x, mean=mean(raw.data$EnergyProduction),
           sd=sd(raw.data$EnergyProduction)) 
y <- y * diff(h$mids[1:2]) * length(raw.data$EnergyProduction) 
lines(x, y, lwd=2)

# Summary:
# doean't look too good. Especially temperature is clearly
# not Gaussian (as expected)
# improvement: use month as factor in a mixed Bayesian network


# linear correlation between variables for Bayesian Network

library(lattice)
splom(raw.data[c("Month", "Temperature",
                 "Daylight", "EnergyProduction")])

# Summary:
# Again, doesn't look good. 
# the only linear tendency might be in Daylight ~ EnergyProduction

# Train BN model with deal

library(deal)
bn.data <- data.frame("Month"=factor(raw.data$Month),
                      "Daylight"=raw.data$Daylight,
                      "Temperature"=raw.data$Temperature,
                      "EnergyProduction"=raw.data$EnergyProduction)

net <- network(bn.data)
net.prior <- jointprior(net)
banlist <- matrix(c(2,3,4,4,4,
                      1,1,1,2,3),
                    ncol=2)
banlist(net) <- banlist
net <- learn(net, bn.data, net.prior)$nw
net <- autosearch(net, bn.data, net.prior, trace=TRUE)$nw

# looks really bad as expected
localposterior(deal::nodes(net)$EnergyProduction)[[6]]
model <- localposterior(deal::nodes(net)$EnergyProduction)[[6]]$mu


# calculate the MAPE 
raw.test.data <- read.table("../../data/test_dataset_500.csv",
                       header=T, sep=",")
test.data <- raw.test.data[c("Daylight", "Temperature",
                             "EnergyProduction")]

# approx. 0.18
MAPE <- mean(apply(test.data, 1,
                   function(x) abs((x[3] -
                                    (model[1] + model[2]*x[1] +
                                     model[3]*x[2])) / x[3] )))
                   
write(MAPE, file="bn1.MAPE")



# lets have a look at the values for different houses: are there any clusters?
library(reshape)
house.melt <- melt(raw.data[,c("House","Daylight",
                                "Temperature",
                                "EnergyProduction")],
                    id=c("House")) 
house.cast <- cast(house.melt,
                    House~variable, mean)
splom(house.cast[c("Temperature", "Daylight",
                 "EnergyProduction")])

# Summary:
# looks like there are two linear models for EnergyPrd~Daylight
# e.g. north/south orientation of the roof for solar power
# or two different efficiencies for energy convergence
# As a time constraint I use "classification by eye" or
# the classification method "from expert knowledge" ;)

L <- c(-2420, 16)
plot(house.cast$Daylight,
     house.cast$EnergyProduction)
abline(L)

G <- apply(house.cast, 1,
           function(x) as.integer (
             x[3] > (x[1]*L[2] + L[1])) )
GG <- as.vector(sapply(G,
            function(x) rep(x,23)))

# any difference?
splom(raw.data[GG==0,c("Month", "Temperature",
                 "Daylight", "EnergyProduction")])
splom(raw.data[GG==1,c("Month", "Temperature",
                 "Daylight", "EnergyProduction")])

# Summary:
# the separation of EnergyPrd~Daylight isn't going to
# improve the performance of the BN


bn.data.2 <- data.frame("G"=factor(GG),
                        "Daylight"=raw.data$Daylight,
                        "Temperature"=raw.data$Temperature,
                        "EnergyProduction"=raw.data$EnergyProduction)

net.2 <- network(bn.data.2)
net.2.prior <- jointprior(net.2)
net.2 <- learn(net.2, bn.data.2, net.2.prior)$nw
net.2 <- autosearch(net.2, bn.data.2, net.2.prior, trace=TRUE)$nw


# as bad as before
localposterior(deal::nodes(net.2)$EnergyProduction)
model <- array(0,dim=c(2,3))
model[1,] <- localposterior(deal::nodes(net.2)$EnergyProduction)[[1]]$mu
model[2,] <- localposterior(deal::nodes(net.2)$EnergyProduction)[[2]]$mu


# calculate MAPE approx 0.18
test.data.g <- test.data
test.data.g$G <- G+1

MAPE <- mean(apply(test.data.g, 1,
                   function(x) abs((x[3] -
                                    (model[x[4],1] + model[x[4],2]*x[1] +
                                     model[x[4],3]*x[2])) / x[3] )))
                   
write(MAPE, file="bn2.MAPE")


##########################
# Conclusions:
# BN perform horribly because there isn't any linear
# relation between Temperature~Daylight and
# EnergyPrd~Temperature
# Additionally, Temperature and Daylight aren't very Gaussian
# The two discrete factors I introduced didn't improve the MAPE.
# Modelling requires great insight into the data and the system.
# With the little information given I cannot think of any better
# way to modell the energy production. It seems the only useful
# variable is daylight and there might be indications for
# two underlying linear models.
# I hope the excercise wasn't to get the MAPE down as much as
# possible. There might be a model which has a better MAPE
# but with so little information about the system this model would
# be over-fitted. If I really had to develop a model I would first
# of all try to understand the system which is to model and then
# improve the data available for modelling.
# With the data and information provided this is the best result
# I came up with. 
