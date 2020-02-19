class PagesController < ApplicationController
  def main
    year_month_groups = Dataset.group(:year,:month).sum(:energy_production)
    # Bar-chart x-axis
    gon.year_months = year_month_groups.keys.sort
    # Bar-chart y-axis
    gon.production = year_month_groups.values
  end
end
