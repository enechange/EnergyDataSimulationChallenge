const get_data = (url) => {
  axios.get('/' + url )
    .then(function (response) {
      scatter_chart(response);
      console.log(response);
    })
    .catch(function (error) {
      alert('エラーが発生しました。');
      console.log(error);
    })
};

const scatter_chart = (dataArray) => {
  const ctx = document.getElementById('myChart1').getContext('2d');
  new Chart(ctx, {
    type: 'scatter',
    data: { datasets: dataArray
        // datasets: [{
        //     label: 'My First dataset',
        //     backgroundColor: '#cfcfcf',
        //     borderColor: '#808080',
        //     // pointRadius: 1,
        //     // pointBorder: 5
        //     data: [{
        //       x: 20,
        //       y: 0
        //     }]
        // }]
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
  get_data('all');
};