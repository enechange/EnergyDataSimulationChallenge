var drawCityProductionChart = function (id, data) {
  var ctx = document.getElementById(id).getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
      labels: Object.keys(data),
      datasets: [{
        data: Object.values(data),
      }],
    },
    options: {
      responsive: true,
      legend: {
        display: false,
      },
      scales: {
        yAxes: [{
          type: 'linear',
          scaleLabel: {
            labelString: 'Energy production',
            display: true,
          },
        }],
      },
    },
  });
};

var drawDaylightProductionChart = function (id, data) {
  var ctx = document.getElementById(id).getContext('2d');
  new Chart.Scatter(ctx, {
    data: {
      datasets: [{
        data: data,
      }],
    },
    options: {
      legend: {
        display: false,
      },
      scales: {
        xAxes: [{
          position: 'bottom',
          ticks: {
            userCallback: function (tick) {
              return tick.toString();
            },
          },
          scaleLabel: {
            labelString: 'Daylight',
            display: true,
          }
        }],
        yAxes: [{
          scaleLabel: {
            labelString: 'Energy production',
            display: true,
          },
        }],
      },
    },
  });
};

window.onload = function () {
  drawCityProductionChart('city_production', gon.city_energy_production);
  drawDaylightProductionChart('daylight_production', gon.daylight_energy_production);
};
