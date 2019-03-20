window.draw_show_graph = ->
  ctx = document.getElementById("EnergyDataChart");
  EnergyDataChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: gon.data_term,
      datasets: [{
        label: 'EnergyProduction',
        type: "bar",
        fill: false,
        data: gon.data_energyprod,
        backgroundColor: "rgb(200, 200, 200, 0.5)",
        borderColor: "rgb(200, 200, 200)",
        yAxisID: "y-axis-1",
      }, {
        label: 'Temperature',
        type: "line",
        fill: false,
        data: gon.data_temperature,
        backgroundColor: "rgb(54, 162, 235)",
        borderColor: "rgb(54, 162, 235)",
        yAxisID: "y-axis-2",
      }, {
        label: 'Daylight',
        type: "line",
        fill: false,
        data: gon.data_daylight,
        backgroundColor: "rgb(255, 0, 0)",
        borderColor: "rgb(255, 0, 0)",
        yAxisID: "y-axis-3",
      }]
    },
    options: {
      tooltips: {
        mode: 'nearest',
        intersect: false,
      },
      responsive: true,
      scales: {
        xAxes: [{
          scaleLabel: {
            display: true,
            labelString: "Month"
          }
        }],
        yAxes: [{
          id: "y-axis-1",
          scaleLabel: {
            display: true,
            labelString: "EnergyProduction"
          },
          type: "linear",
          position: "left",
          ticks: {
            max: 1500,
            min: 0,
            stepSize: 100
          },
        }, {
          id: "y-axis-2",
          scaleLabel: {
            display: true,
            labelString: "Daylight"
          },
          type: "linear",
          position: "right",
          ticks: {
            max: 40,
            min: -5,
            stepSize: 5
          },
          gridLines: {
            drawOnChartArea: false,
          },
        }, {
          id: "y-axis-3",
          type: "linear",
          position: "right",
          ticks: {
            max: 500,
            min: 0,
            stepSize: 25
          },
          gridLines: {
            drawOnChartArea: false,
          },
        }],
      },
    }
  })