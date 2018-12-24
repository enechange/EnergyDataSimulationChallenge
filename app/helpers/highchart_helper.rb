module HighchartHelper
  def series_temperatures(data_sets)
    {
      name: I18n.t('models.data_set.temperature'),
      type: 'spline',
      yAxis: 2,
      data: data_sets.map(&:temperature),
    }
  end

  def series_daylights(data_sets)
    {
      name: I18n.t('models.data_set.daylight'),
      type: 'spline',
      yAxis: 1,
      data: data_sets.map(&:daylight),
    }
  end

  def series_energy_productions(data_sets)
    {
      name: I18n.t('models.data_set.energy_production'),
      type: 'column',
      yAxis: 0,
      data: data_sets.map(&:energy_production),
    }
  end
end
