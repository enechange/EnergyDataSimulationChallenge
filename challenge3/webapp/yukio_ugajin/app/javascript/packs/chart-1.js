// const get_data = () => {

// };
const scatter_chart = () => {
  const ctx = document.getElementById('myChart1').getContext('2d');
  new Chart(ctx, {
    type: 'scatter',
    data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
            label: 'My First dataset',
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: [{
              x: 20,
              y: 0
          }, {
              x: 0,
              y: 10
          }, {
              x: 11,
              y: 5
          }]
        }]
    },
    options: {
      // responsive: true, // レスポンシブ設定
      maintainAspectRatio: true, // アスペクト比の維持設定
      scales: {
        xAxes: [{
          scaleLabel: {
            display: true,
            labelString: 'Daylight'
          }
        }],
        yAxes: [{
          scaleLabel: {
            display: true,
            labelString: 'Energy Production'
          }
        }]
      }
    }
  })
};

window.onload = () => {
  scatter_chart();
};