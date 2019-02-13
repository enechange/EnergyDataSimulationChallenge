(function() {
  window.energyProductionChart = function() {
    var ctx = document.getElementById("energy-production-chart");
    var energyProductionLabel = 'エネルギー発電量'
    var dayLightLabel = '日射量'
    var blueColor = 'rgba(54, 162, 235)'
    var opacityBlueColor = 'rgba(54, 162, 235, 0.2)' 
    var redColor = 'rgba(255, 99, 132)'
    var opacityRedColor = 'rgba(255, 99, 132, 0.2)' 

    var energyProductionChart = new Chart(ctx, {
      type: 'bar',
      data: {
        datasets: [{
          data: gon.energy_production,
          yAxisID: 'A',
          label: energyProductionLabel,
          backgroundColor: opacityBlueColor,
          borderWidth: 1,
          borderColor: blueColor
        }, {
          data: gon.daylight,
          type: 'line',
          yAxisID: 'B',
          label: dayLightLabel,
          fill: false,
          backgroundColor: opacityRedColor,
          borderColor: redColor
        }],
        labels: gon.date_label
      },
      options: {
        scales: {
          yAxes: [{
            id: 'A',
            position: 'left',
            ticks: {
              beginAtZero: true
            },
            scaleLabel: {
              display: true,
              labelString: energyProductionLabel,
              fontSize: 20
            }
          }, {
            id: 'B',
            position: 'right',
            ticks: {
              beginAtZero: true
            },
            scaleLabel: {
              display: true,
              labelString: dayLightLabel,
              fontSize: 20
            }
          }],
          xAxes: [{
            scaleLabel: {
              display: true,
              labelString: '日付',
              fontSize: 20
            }
          }]
        }
      }
    });
  };
})();
