$(function() {
  google.setOnLoadCallback(drawChart);
  google.setOnLoadCallback(drawTemperatureChart);

  function drawChart() {
    var data = google.visualization.arrayToDataTable(gon.energies);

    var options = {
      legend: { position: 'none'},
      title: 'EnergyProduction'
    };

    var chart = new google.visualization.ColumnChart(document.getElementById('chart'));
    chart.draw(data, options);
  }

  function drawTemperatureChart() {
    var temperatures =
      gon.temperatures.map(function(element, index, _) {
        if (index === 0) { return element; };
        return [element[0], Number(element[1])];
      });
    var data = google.visualization.arrayToDataTable(temperatures);
    var options = {
      legend: { position: 'none'},
      title: "Temperature"
    };

    var chart = new google.visualization.LineChart(document.getElementById('temperature-chart'));
    chart.draw(data, options);
  }
})
