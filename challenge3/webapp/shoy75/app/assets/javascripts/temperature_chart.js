var temperature = ['Temperature'];
var energy_production = ['EnergyProduction'];
var chart = c3.generate({
  bindto: '#temperature-chart',
  data: {
    xs: {
      'EnergyProduction': 'Temperature'
    },
    columns: [
      temperature.concat(gon.temperature),
      energy_production.concat(gon.energy_production),      
    ],
    type: 'scatter'
  },
  axis: {
    x: {
      label: 'Temperature'
    },
    y: {
      label: 'Energy Production'
    }
  }
});
