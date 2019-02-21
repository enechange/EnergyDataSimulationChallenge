var month = ['Month'];
var energy_production = ['EnergyProduction'];
var chart = c3.generate({
  bindto: '#house_chart',
  data: {
    xs: {
      'EnergyProduction': 'Month'
    },
    xFormat: '%Y/%m',
    columns: [
      month.concat(gon.month),
      energy_production.concat(gon.energy_production)
    ]
  },
  axis: {
    x: {
      type: 'timeseries',
      label: 'Month'
    },
    y: {
      label: 'Energy Production'
    }
  }
});
