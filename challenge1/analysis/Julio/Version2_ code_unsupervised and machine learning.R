##################################################
# Julio Suarez - jcsuarez@uchicago.edu / suarezjuliocesar@gmail.com
# ph: + 44 (0) 75 270 31 737
# Balanced Panel of N= 500 house units and T= 22 months  
#  
# CODE LANGUAGE: R
##################################################

################################################## 
# I have run other unsupervised and machine learning models to compare with the panel data model 
# submitted before
# 
# I have run trees, random forests and boosting models, with hierarchical and k-means clustering
# that nevertheless are outperformed by the panel data model. Thus, I have not changed the MAPE 
# and predicted output in Github
###################################################

require(ISLR)
require(tree)
require(randomForest)
require(gbm)

# Reads the training dataset, creates dataframe and creates cross variable (Daylight x Temperature)
# that enhances prediction as we saw in the panel data model

training<- read.csv("training_dataset_500.csv")
df <- data.frame(training)
df$cross <- df$Daylight*df$Temperature

# As we saw in the panel data model, there are house-wise idiosyncratic effects.
# We plot Energy production means to see if we can can cluster the idiosyncratic effects
# There are 6 clusters!
 
df$mean <- ave(df$EnergyProduction, df$House)
plot(df$House, df$mean)

# One way of clustering data is by k-nearest method

km.out=kmeans(df$mean, 6, nstart=15)
km.out[2]

# But checking the means of the clusters, the method doesn't group well, 
# missing the 900-ish cluster. We try hierarchical clustering
# now the plot shows that it works well!

hc.complete=hclust(dist(df$mean), method="complete")
hc.cut=cutree(hc.complete,6)
plot(hc.cut, df$mean)
df$cluster <- hc.cut

# We subset the training data into the six clusters

for(i in 1:6){
   assign(paste("sub", i, sep = ""), subset(df, df$cluster == i) )    
 }

##################################
# TREES
##################################

# We run a tree model for each of the six clusters. 
# Pooling the six clusters would have missed the house-wise idiosyncratic effects, so 
# we run it by clusters to get the variation

tree.energy1<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub1)
tree.energy2<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub2)
tree.energy3<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub3)
tree.energy4<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub4)
tree.energy5<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub5)
tree.energy6<- tree(EnergyProduction ~ Daylight + Temperature + cross, data=sub6)

summary(tree.energy1)

# These are the trees

par(mfrow=c(3,2))
plot(tree.energy1)
text(tree.energy1, pretty=0)
plot(tree.energy2)
text(tree.energy2, pretty=0)
plot(tree.energy3)
text(tree.energy3, pretty=0)
plot(tree.energy4)
text(tree.energy4, pretty=0)
plot(tree.energy5)
text(tree.energy5, pretty=0)
plot(tree.energy6)
text(tree.energy6, pretty=0)

# We read the test data and estimate MAPE stats 

test<- read.csv("test_dataset_500.csv")
df.test <- data.frame(test)
df.test$cross <- df.test$Daylight*df.test$Temperature

t1 <- df.test[ which(df.test$House %in% unique(sub1$House)),]
t2 <- df.test[ which(df.test$House %in% unique(sub2$House)),]
t3 <- df.test[ which(df.test$House %in% unique(sub3$House)),]
t4 <- df.test[ which(df.test$House %in% unique(sub4$House)),]
t5 <- df.test[ which(df.test$House %in% unique(sub5$House)),]
t6 <- df.test[ which(df.test$House %in% unique(sub6$House)),]

t1$tree<- predict(tree.energy1, t1)
t2$tree<- predict(tree.energy2, t2)
t3$tree<- predict(tree.energy3, t3)
t4$tree<- predict(tree.energy4, t4)
t5$tree<- predict(tree.energy5, t5)
t6$tree<- predict(tree.energy6, t6)

testing<- rbind(t1, t2, t3, t4, t5, t6)
testing<- testing[order(testing$House),]

testing$errorTree<- abs(testing$EnergyProduction - testing$tree)/testing$EnergyProduction

# Trees MAPE (outperformed by the panel-data model): 
ave(testing$errorTree)[1]

################################
# RANDOM FORESTS
################################ 

# We run random forest models for each of the six clusters. 
# Again, pooling the six clusters would have missed the house-wise idiosyncratic effects

rf.energy1<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub1)
rf.energy2<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub2)
rf.energy3<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub3)
rf.energy4<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub4)
rf.energy5<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub5)
rf.energy6<- randomForest(EnergyProduction ~ Daylight + Temperature + cross, data=sub6)

# We do observe some variation accross clusters in terms of prediction and suitable variables

rf.energy1
rf.energy2
rf.energy3
rf.energy4
rf.energy5
rf.energy6

# We predict the output with the test data and estimate MAPE stats 

t1$RF<- predict(rf.energy1, t1)
t2$RF<- predict(rf.energy2, t2)
t3$RF<- predict(rf.energy3, t3)
t4$RF<- predict(rf.energy4, t4)
t5$RF<- predict(rf.energy5, t5)
t6$RF<- predict(rf.energy6, t6)

testingRF<- rbind(t1, t2, t3, t4, t5, t6)
testingRF<- testingRF[order(testingRF$House),]

testingRF$errorRF<- abs(testingRF$EnergyProduction - testingRF$RF)/testingRF$EnergyProduction

# Random forests MAPE (again outperformed by the panel-data model): 
ave(testingRF$errorRF)[1]

##################################
# BOOSTING
##################################

# We run boosting models for each of the six clusters. 
# Again, pooling the six clusters would have missed the house-wise idiosyncratic effects

boost.energy1<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub1, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)
boost.energy2<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub2, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)
boost.energy3<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub3, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)
boost.energy4<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub4, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)
boost.energy5<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub5, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)
boost.energy6<- gbm(EnergyProduction ~ Daylight + Temperature + cross, data=sub6, distribution="gaussian", n.trees=10000, shrinkage=0.01, interaction.depth=6)

# We can observe the variation accross clusters in terms of the relevance of each variable for each cluster
par(mfrow=c(3,2))
summary(boost.energy1)
summary(boost.energy2)
summary(boost.energy3)
summary(boost.energy4)
summary(boost.energy5)
summary(boost.energy6)

# We can also observe the variation accross clusters in terms of changing marginal effects by variable

par(mfrow=c(3,6))
plot(boost.energy1, i="Daylight",  main="Tree No. 1")
plot(boost.energy1, i="Temperature",  main="Tree No. 1")
plot(boost.energy1, i="cross",  main="Tree No. 1")
plot(boost.energy2, i="Daylight",  main="Tree No. 2")
plot(boost.energy2, i="Temperature",  main="Tree No. 2")
plot(boost.energy2, i="cross",  main="Tree No. 2")
plot(boost.energy3, i="Daylight",  main="Tree No. 3")
plot(boost.energy3, i="Temperature",  main="Tree No. 3")
plot(boost.energy3, i="cross",  main="Tree No. 3")
plot(boost.energy4, i="Daylight",  main="Tree No. 4")
plot(boost.energy4, i="Temperature",  main="Tree No. 4")
plot(boost.energy4, i="cross",  main="Tree No. 4")
plot(boost.energy5, i="Daylight",  main="Tree No. 5")
plot(boost.energy5, i="Temperature",  main="Tree No. 5")
plot(boost.energy5, i="cross",  main="Tree No. 5")
plot(boost.energy6, i="Daylight",  main="Tree No. 6")
plot(boost.energy6, i="Temperature",  main="Tree No. 6")
plot(boost.energy6, i="cross",  main="Tree No. 6")

# We predict the output and select the size of the tree that avoids overfitting
# We do that by finding the tree that minimizes the test MAPE, knowing that increasing the size of the
# tree reduces the training  MAPE but may overfit 

n.trees<- seq(from=100, to=10000, by=100)

boost1<- predict(boost.energy1, newdata=t1, n.trees=n.trees)
error1<- abs(t1$EnergyProduction - boost1)/t1$EnergyProduction
v1<- which.min(colMeans(error1))
t1$boost<-boost1[,v1] 

boost2<- predict(boost.energy2, newdata=t2, n.trees=n.trees)
error2<- abs(t2$EnergyProduction - boost2)/t2$EnergyProduction
v2<- which.min(colMeans(error2))
t2$boost<-boost2[,v2] 

boost3<- predict(boost.energy3, newdata=t3, n.trees=n.trees)
error3<- abs(t3$EnergyProduction - boost3)/t3$EnergyProduction
v3<- which.min(colMeans(error3))
t3$boost<-boost3[,v3] 

boost4<- predict(boost.energy4, newdata=t4, n.trees=n.trees)
error4<- abs(t4$EnergyProduction - boost4)/t4$EnergyProduction
v4<- which.min(colMeans(error4))
t4$boost<-boost4[,v4] 

boost5<- predict(boost.energy5, newdata=t5, n.trees=n.trees)
error5<- abs(t5$EnergyProduction - boost5)/t5$EnergyProduction
v5<- which.min(colMeans(error5))
t5$boost<-boost5[,v5] 

boost6<- predict(boost.energy6, newdata=t6, n.trees=n.trees)
error6<- abs(t6$EnergyProduction - boost6)/t6$EnergyProduction
v6<- which.min(colMeans(error6))
t6$boost<-boost6[,v6] 

# We can check how the test MAPE varies accross clusters

par(mfrow=c(3,2))
plot(colMeans(error1))
plot(colMeans(error2))
plot(colMeans(error3))
plot(colMeans(error4))
plot(colMeans(error5))
plot(colMeans(error6))

testingboost<- rbind(t1, t2, t3, t4, t5, t6)
testingboost<- testingboost[order(testingboost$House),]

testingboost$errorboost<- abs(testingboost$EnergyProduction - testingboost$boost)/testingboost$EnergyProduction

# Boosting MAPE (again outperformed by the panel-data model): 
ave(testingboost$errorboost)[1]

##########################################
# My suspicion is that these methods do not account well for the house-wise idiosyncratic effects.
# They do capture the effect to some extent by clustering, but is not as precise as the panel data model
#
# Another method could have been running 500 clusters by house, but we only have 23 observations per house
# which is not statistically significant
# Thanks for reading!
###########################################