const ctx = document.getElementById('myChart2').getContext('2d');
// debugger;
const chart = new Chart(ctx, {
  // The type of chart we want to create
  type: 'bar',

  // The data for our dataset
  data: {
      labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
      datasets: [{
          label: 'My First dataset',
          backgroundColor: '#FFEA00',
          borderColor: '#FFBB00',
          data: [0, 10, 5, 2, 20, 30, 45]
      }]
  },

  // Configuration options go here
  options: {}
});