train_data <- read.table("training_dataset_500.csv", head=T, sep=",")

train_data_Jun <- subset(train_data[train_data$Year == 2012,], Month == 6, c(Temperature, Daylight,EnergyProduction))
train_data_May <- subset(train_data[train_data$Year == 2012,], Month == 5, c(Temperature, Daylight,EnergyProduction))
train_data_Apr <- subset(train_data[train_data$Year == 2012,], Month == 4, c(Temperature, Daylight,EnergyProduction))

norm_train_data_Jun <- train_data_Jun/train_data_May
norm_train_data_May <- train_data_May/train_data_Apr

row<- nrow(norm_train_data_Jun)
norm_train_data_Jun$Month  <- rep(6,row)
norm_train_data_May$Month  <- rep(5,row)


norm_train_data2012 <- rbind(norm_train_data_Jun,norm_train_data_May)
result <- lm(EnergyProduction ~   I(Daylight^1) + I(Month^1), data = norm_train_data2012)

EnergyProduction <- norm_train_data2012[,3]
res <- residuals(result)
mean(abs(res/EnergyProduction))

row2<- length(EnergyProduction)
win.graph()
plot(1:row2,EnergyProduction )
lines(1:row2,result$fitted.values, col="red",lty=2)

result
summary(result)

