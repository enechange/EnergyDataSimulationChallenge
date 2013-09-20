test_data <- read.table("test_dataset_500.csv", head=T, sep=",")
train_data <- read.table("training_dataset_500.csv", head=T, sep=",")

dayl_test_data_Jun2013 <- test_data$Daylight
energy_test_data_Jun2013 <- test_data$EnergyProduction

dayl_train_data_May2013 <- subset(train_data[train_data$Year == 2013,], Month == 5, Daylight)
energy_train_data_May2013 <- subset(train_data[train_data$Year == 2013,], Month == 5, EnergyProduction)

X_dayl_Jun2013 <- dayl_test_data_Jun2013/dayl_train_data_May2013
Y_pred_Jun2013 <- 1.111459 + 0.353560*X_dayl_Jun2013 -0.085053 * test_data$Month

pred_energy_Jun2013<- energy_train_data_May2013 * Y_pred_Jun2013
House <- c(1:nrow(pred_energy_Jun2013))

write.csv(cbind(House,pred_energy_Jun2013),"predicted_energy_production.csv",row.names=F)

abserr <- abs(pred_energy_Jun2013-energy_test_data_Jun2013)/energy_test_data_Jun2013
mape <- mean(abserr$EnergyProduction)
write.table(mape,"mape.txt",row.names=F,col.names = F)

