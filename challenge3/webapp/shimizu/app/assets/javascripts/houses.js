window.draw_graph_scatter = function () {
  ctx = document.getElementById("scatterChart").getContext('2d');
  return scatterChart = new Chart(ctx, {
    type: 'scatter',
    data: {
      datasets: [{
        data: gon.energy_production_daylight,
        backgroundColor: 'Blue'
      }]
    },
    options: {
      legend: {
        display: false
      },
      scales: {
        xAxes: [{
          ticks: {
            max: 300,
            min: 100
          },
          scaleLabel: {
            labelString: 'Daylight',
            display: true,
            fontSize: 20
          }
        }],
        yAxes: [{
          ticks: {
            max: 1200,
            min: 200
          },
          scaleLabel: {
            labelString: 'Energy production',
            display: true,
            fontSize: 20
          }
        }]
      }
    }
  });
};

window.draw_graph_line = function () {
  ctx = document.getElementById("lineChart").getContext('2d');
  return lineChart = new Chart(ctx, {
    type: 'line',
    data: {
      labels: gon.month,
      datasets: [{
          label: gon.first_name,
          data: gon.energy_in_house,
          borderColor: "Red",
          backgroundColor: "Red",
          fill: false
        },{
          label: 'overall average',
          data: gon.overall_average,
          borderColor: "Blue",
          backgroundColor: "Blue",
          fill: false
        }
      ]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            suggestedMax: 1200,
            suggestedMin: 200
          },
          scaleLabel: {
            labelString: 'Energy production',
            display: true,
            fontSize: 20
          }
        }]
      }
    }
  });
};
