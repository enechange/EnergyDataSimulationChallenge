getDataSet();

const selectElement = document.querySelector('.house');
selectElement.addEventListener('change', (event) => {
  const result = document.querySelector('.result');
  result.textContent = `You like ${event.target.value}`;
  
  getDataSet();
});

function getDataSet() {
  let dataset = {
    yearMonth: [],
    temperature: [],
    daylight: [],
    energyProduction: []
  };

  fetch("/get_data")
    .then(response => response.json())
    .then((data) => {
      dataset.yearMonth = data['year_month'];
      dataset.energyProduction = data['production'];
      data['temperature'].forEach(element => {
        dataset.temperature.push(parseFloat(element));
      });
      data['daylight'].forEach(element => {
        dataset.daylight.push(parseFloat(element));
      });  
      drawChart(dataset);
    });
}

function drawChart(dataset) {
  console.log(dataset);
  const ctx = document.getElementById('myChart').getContext('2d');
  const myChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: dataset.yearMonth,
      datasets: [{
        label: 'Energy production',
        data: dataset.energyProduction,
        backgroundColor: 'rgba(0, 153, 0, 0.5)',
        borderColor: 'rgba(0, 153, 0, 0.8)',
        borderWidth: 1,
        yAxisID: "y-axis-left"
      }, {
        label: 'Temperature',
        data: dataset.temperature,
        backgroundColor: 'rgba(255, 204, 255, 0.5)',
        borderColor: 'rgba(255, 204, 255, 0.5)',
        type: 'line',
        yAxisID: "y-axis-right-1"
      }, {
        label: 'Day light',
        data: dataset.daylight,
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
}
