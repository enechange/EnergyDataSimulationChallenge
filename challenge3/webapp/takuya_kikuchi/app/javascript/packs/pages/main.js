// House#1 initially displayed
getDataSet(1);

// Select form onchange action
const selectElement = document.querySelector('.house');
selectElement.addEventListener('change', (event) => {
  // Passing house_id to generate chart
  const house = event.target.value;
  getDataSet(house);
});

function getDataSet(house) {
  let dataset = {
    yearMonth: [],
    temperature: [],
    daylight: [],
    energyProduction: []
  };
  let houseInfo = {};

  fetch(`/get_data?house_id=${house}`)
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
      houseInfo = data['house'];
      getHouseInfo(houseInfo);
      drawChart(dataset);
    });
}

function getHouseInfo(house) {
  // Display house information
  const result = document.querySelector('.result'); 
  result.innerHTML = 
    `<ul>
      <li>ID: ${house['id']}</li>
      <li>Name: ${house['first_name']} ${house['last_name']}</li>
      <li>City: ${house['city']}</li>
      <li>Number of people: ${house['num_of_people']}</li>
      <li>Has child: ${house['has_child']}</li>
    </ul>`;
}

function drawChart(dataset) {
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
          scaleLabel: {
            display: true,
            labelString: 'kWh',
            fontSize: 12
          },
          position: "left",
            ticks: {
              beginAtZero: true,
              min: 0,
              max: 1100
            }
          },
          {
            id: "y-axis-right-1",
            scaleLabel: {
              display: true,
              labelString: 'Celsius',
              fontSize: 12
            },
            position: "right"
          },
          {
            id: "y-axis-right-2",
            scaleLabel: {
              display: true,
              labelString: 'kW/m2',
              fontSize: 12
            },
            position: "right"
          }],
      }
    }
  });
}
