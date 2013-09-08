energy.data <- read.csv("../../data/training_dataset_500.csv")
energy.lm <- lm(EnergyProduction~Month + Temperature + Daylight, data=energy.data)
summary(energy.data)
summary(energy.lm)
