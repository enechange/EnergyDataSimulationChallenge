// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
Highcharts.chart('container', {
  chart: { zoomType: 'xy' },
  title: { text: chart_title },
  xAxis: [{
    categories: seasons,
    crosshair: true
  }],
  yAxis: [{ // Primary yAxis
    title: {
      text: energy_productions.name,
      style: { color: Highcharts.getOptions().colors[0] }
    },
    labels: {
      format: '{value} A',
      style: { color: Highcharts.getOptions().colors[0] }
    },
  }, { // Secondary yAxis
    title: {
      text: daylights.name,
      style: { color: Highcharts.getOptions().colors[1] }
    },
    labels: {
      format: '{value} hours',
      style: { color: Highcharts.getOptions().colors[1] }
    },
    gridLineWidth: 0,
    opposite: true
  }, { // Tertiary yAxis
    title: {
      text: temperatures.name,
      style: { color: Highcharts.getOptions().colors[2] }
    },
    labels: {
      format: '{value} °C',
      style: { color: Highcharts.getOptions().colors[2] }
    },
    gridLineWidth: 0,
    opposite: true
  }],
  tooltip: { shared: true },
  legend: {
    layout: 'vertical',
    align: 'left',
    x: 80,
    verticalAlign: 'top',
    y: 55,
    floating: true,
    backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || 'rgba(255,255,255,0.25)'
  },
  series: [energy_productions, daylights, temperatures]
});
