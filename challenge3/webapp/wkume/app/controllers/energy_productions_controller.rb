class EnergyProductionsController < ApplicationController
  include CommonCalc
  
  def index
    
    energy_production_house = EnergyProduction.includes(:house)
    energy_production = EnergyProduction.all
    
    
    # prepare labels/data for bar chart
    count_result = House.group(:city).count.sort.to_h
    
    # pass labels/data
    gon.labels_bar = count_result.keys
    gon.data_bar = count_result.values
    
    
    # prepare labels for line chart
    label_list = energy_production.distinct.pluck(:label).sort
    
    # pass labels
    gon.labels_line = self.class.label_month_converter(energy_production, label_list)
    
    
    # prepare city list for grouping
    city_list = House.distinct.pluck(:city)
    
    # prepare data for line chart
    gon.data_line = {}
    city_list.each do |city|
      
      eph_h = energy_production_house.where(houses: { city: city })
      
      # pass data
      production = eph_h.group("label").average("energy_production")
      gon.data_line[city] = production.values.map{ |v| v.round(1)}
    end
    
  end
  
  
  def self.label_month_converter(model, labels)
    year = nil
    months = []
    
    labels.each do |label|
      r = model.find_by(label: label)
      
      if year == nil || r.year > year
        year = r.year
        months << "#{r.year}/#{r.month}"
        next
      end
      
      months << "#{r.month}"
    end
    
    return months
  end
  
end
