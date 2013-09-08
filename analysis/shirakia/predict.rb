require 'csv'

INTERCEPT = 137.41758
MONTH_COEFFICIENT = -9.38380
TEMPERATURE_COEFFICIENT = 6.37583
DAYLIGHT_COEFFICIENT = 2.35242
DATASET_SIZE = 500

def predict(month, temperature, daylight)
  INTERCEPT +
    month * MONTH_COEFFICIENT +
    temperature * TEMPERATURE_COEFFICIENT +
    daylight * DAYLIGHT_COEFFICIENT
end

def calculate_mape(actual_productions, predicted_productions)
  absolute_percentage_error_sum = 0.0
  actual_productions.zip(predicted_productions).each do |actual_production, predicted_production|
    absolute_percentage_error_sum += (actual_production.to_f - predicted_production.to_f).abs / actual_production.to_f
  end
  absolute_percentage_error_sum / DATASET_SIZE
end

reader = CSV.open("../../data/test_dataset_500.csv", "r")
header = reader.take(1)[0]
actual_productions = []
predicted_productions = []

reader.each do |row|
  month = row[4].to_i
  temperature = row[5].to_f
  daylight = row[6].to_f
  actual_production = row[7].to_i

  actual_productions.push actual_production
  predicted_productions.push predict(month, temperature, daylight)
end

CSV.open("predicted_energy_production.csv", "w") do |row|
  row << ["House", "EnergyProduction"]
  predicted_productions.each_with_index do |predicted_production, i|
    row << [i+1, predicted_production]
  end
end

File.open("mape.txt", "w") do |row|
  row << calculate_mape(actual_productions, predicted_productions)
end
