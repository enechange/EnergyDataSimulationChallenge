const ctx = document.getElementById('myChart').getContext('2d');
const myChart = new Chart(ctx, {
  type: 'bar',
  data: {
    labels: gon.year_months,
    datasets: [{
      label: 'Energy production',
      data: gon.production,
      backgroundColor: 'rgba(0, 153, 0, 0.5)',
      borderColor: 'rgba(0, 153, 0, 0.8)',
      borderWidth: 1,
      yAxisID: "y-axis-left"
    }, {
      label: 'Temperature',
      data: gon.temperature,
      backgroundColor: 'rgba(255, 204, 255, 0.5)',
      borderColor: 'rgba(255, 204, 255, 0.5)',
      type: 'line',
      yAxisID: "y-axis-right-1"
    }, {
      label: 'Day light',
      data: gon.daylight,
      backgroundColor: 'rgba(255, 255, 153, 0.5)',
      borderColor: 'rgba(255, 255, 153, 0.5)',
      type: 'line',
      yAxisID: "y-axis-right-2"
    }]
  },
  options: {
    scales: {
      yAxes: [
        {
        id: "y-axis-left",
        position: "left",
          ticks: {
            beginAtZero: true
          }
        },
        {
          id: "y-axis-right-1",
          position: "right"
        },
        {
          id: "y-axis-right-2",
          position: "right"
        }],
    }
  }
});