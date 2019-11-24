const select_box = document.getElementById('select_box');

const get_data = (url) => {
  axios.get('/' + url )
    .then(function (response) {
      scatter_chart(response.data);
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
    data: { datasets: dataArray },
    options: {
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

const line_chart = () => {
  const ctx = document.getElementById('myChart2').getContext('2d');
  new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
        datasets: [{
            label: 'My First dataset',
            backgroundColor: '#FFEA00',
            borderColor: '#FFBB00',
            data: [0, 10, 5, 2, 20, 30, 45]
        }]
    },

    options: {
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
  });
};

window.onload = () => {
  get_data('all');
  line_chart();
};

select_box.addEventListener('change', (e) => {
  get_data(e.target.value);
});

