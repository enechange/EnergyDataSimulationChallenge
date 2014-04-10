# Julio Suarez - jcsuarez@uchicago.edu
# ph: + 44 (0) 75 270 31 737
# Selection of best theoretical model of energy demand at the house level
# Balanced Panel of N= 500 house units and T= 22 months  
#  
# CODE LANGUAGE: R

#Requires package plm for data panel models
require(plm)

#Uploads data
training<- read.csv("training_dataset_500.csv")

#transforms data into a dataframe
df <- data.frame(training)

# Running a naïve OLS. 
# Coefficients look nice but errors don't look well behaved. Suggests bias
Naiv_ols <-lm(EnergyProduction ~ Daylight + Temperature, data=df)
summary(Naiv_ols)
plot(residuals(Naiv_ols))
hist(residuals(Naiv_ols))

# Looking at the rough data, it seems that there are clusters by house -  
# that is, possible heterogeneous effects by house that should be accounted for
df$mean <- ave(df$EnergyProduction, df$House)
plot(df$House, df$EnergyProduction) 
lines(df$House, df$mean, col=2) 

# Creates cross variable of Daylight x Temperature to identify 
# interaction factors of both variables
df$cross <- df$Daylight*df$Temperature

# The variable "cross" ads prediction according to Anova
ols <-lm(EnergyProduction ~ Daylight + Temperature + cross, data=df)
anova (ols, Naiv_ols)

#For comparisson reasons, we run again an OLS but under a plm funtion (pooled panel)
pooled <- plm(EnergyProduction ~ Daylight + Temperature + Daylight*Temperature, data=df, index=c("House", "Label"), model="pooling")

# Running a Breusch-Pagan test, we confirm that OLS (pooled) exhibits 
# heterogeneous factors (random or fixed effects) at the house level that should 
# be accounted for
plmtest(pooled, type=c("bp"))

# We run a random effects model to elimnate posisble random heterogeneous effects. Theoretically it looks like:
#
# EP (it) = Bo + B1 Daylight(it) + B2 Temperature(it) + B3 DaylightxTemperature(it) + vi + u(it)
# 
# Where we want to eliminate the vi, which is a random idiosyncratic error at the house level 
# as BP test and previous plots suggested 

random <- plm(EnergyProduction ~ Daylight + Temperature + cross, data=df, index=c("House", "Label"), model="random")

# But we also should assess if there are "fixed effects", that is, idiosyncratic non-random 
# fixed heterogeneity at the house level. Theoretically looks like:
#
# EP (it) = Bo + B1 Daylight(it) + B2 Temperature(it) + B3 DaylightxTemperature(it) + Ci + u(it)
#
# Where Ci, is the fixed, non-random idiosincratic error at the house level that we want to eliminate
# by substracting the house-level average of each variable
fixed <- plm(EnergyProduction ~ Daylight + Temperature + cross, data=df, index=c("House", "Label"), model="within")

# Under an F test, it does look that fixed effects is better than OLS
pFtest(fixed, ols)

# Under a Hausman test, we identify that Fixed effects is more efficient than random effects at 
# eliminating the idiosyncratic house-level terms
phtest(fixed, random)

# Another way of dealing with idiosyncratic terms is by a first time-difference that substracts 
# the above mentioned Ci term. We do this with a first-difference: 
firstdiff <- plm(EnergyProduction ~ Daylight + Temperature + cross + 0, data=df, index=c("House", "Label"), model="fd")

# We check if adding polynomial terms (non linearities) improve our results and if 
# transforming our results in log terms adds variance and thus prediction. It does! 
polyfirst <- plm(log(EnergyProduction) ~  log(Daylight) + Temperature +  I(Temperature^2) + cross +0, data=df, index=c("House", "Label"), model="fd")
summary(polyfirst)

# The residuals look well behaved now
plot(residuals(polyfirst))
hist(residuals(polyfirst))

# We read the test data and generate a small two-period data frame to run our 
# first-difference non linear panel model (polyfirst) that was theoretically and empirically suitable
test<- read.csv("test_dataset_500.csv")
df.test <- data.frame(test)
df.test$cross <- df.test$Daylight*df.test$Temperature
df.test$mean <- ave(df.test$EnergyProduction, df.test$House)
testeo <- rbind(df, df.test)
testeo22<-testeo[!(testeo$Label!=22),]
testeo23<-testeo[!(testeo$Label!=23),]
testeo23$xL1 <- log(testeo23$Daylight)-log(testeo22$Daylight)
testeo23$x2 <- testeo23$Temperature-testeo22$Temperature
testeo23$x3 <- testeo23$cross-testeo22$cross

# we find fitted and MAPE values for the test data
testeo23$yhatPol<- exp(polyfirst$coefficients[1]*testeo23$xL1 + polyfirst$coefficients[2]*testeo23$x2 + polyfirst$coefficients[3]*(testeo23$x2*testeo23$x2) + polyfirst$coefficients[4]*testeo23$x3 + log(testeo22$EnergyProduction))
testeo23$errorPol<- abs(testeo23$EnergyProduction - testeo23$yhatPol)/testeo23$EnergyProduction

# Print values
write.table(ave(testeo23$errorPol)[1], file = "MAPE.txt", row.names=F, col.names=F)
write.csv(testeo23$yhatPol, file = "predicted_energy_production.csv")

#Thanks for reading!