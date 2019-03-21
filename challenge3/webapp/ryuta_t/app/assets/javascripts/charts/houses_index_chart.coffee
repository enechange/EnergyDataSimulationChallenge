window.draw_graph = ->
  ctx = document.getElementById("myChart");
  myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: gon.data_term,
      datasets: [{
        label: gon.data_city[0],
        data: gon.house_data[0],
        backgroundColor:'rgba(255, 99, 132, 0.2)',
        borderColor:'rgba(255,99,132,1)',
        borderWidth: 1,
        yAxisID: "y-axis-1"
      }, {
        label: gon.data_city[1],
        data: gon.house_data[1],
        backgroundColor: 'rgba(54, 162, 235, 0.2)',
        borderColor:'rgba(54, 162, 235,1)',
        borderWidth: 1,
        yAxisID: "y-axis-1"
      }, {
        label: gon.data_city[2],
        data: gon.house_data[2],
        backgroundColor:'rgba(255, 206, 86, 0.2)',
        borderColor:'rgba(255, 206, 86,1)',
        borderWidth: 1,
        yAxisID: "y-axis-1"
      },
        {
          label: gon.data_city[0],
          type: "line",
          fill: false,
          data: gon.house_amount[0],
          borderColor: "rgb(255, 0, 0)",
          yAxisID: "y-axis-2"
        },{
          label: gon.data_city[1],
          type: "line",
          fill: false,
          data: gon.house_amount[1],
          borderColor: "rgb(54, 105, 235)",
          yAxisID: "y-axis-2"
        },{
          label: gon.data_city[2],
          type: "line",
          fill: false,
          data: gon.house_amount[2],
          borderColor: "rgb(255, 200, 0)",
          yAxisID: "y-axis-2"
        }]
    },
    options: {
      responsive: true,
      scales: {
        yAxes: [{
          id: "y-axis-1",
          scaleLabel: {
            display: true,
            labelString: "EnergyProduction/per year"
          },
          type: "linear",
          ticks: {
            max: 1000,
            min: 0,
            stepSize: 50
          },
          position: "left"
        },{
          id: "y-axis-2",
          scaleLabel: {
            display: true,
            labelString: "Amount"
          },
          type: "linear",
          position: "right",
          ticks: {
            max: 100,
            min: 0,
            stepSize: 5
          },
          gridLines: {
            drawOnChartArea: false
          }
        }
        ]
      }
    }
  })