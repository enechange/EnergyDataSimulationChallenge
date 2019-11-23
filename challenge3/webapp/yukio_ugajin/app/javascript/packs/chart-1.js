const select_box = document.getElementById('select_box');

let get_data = (url) => {
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

window.onload = () => {
  get_data('all');
};

select_box.addEventListener('change', (e) => {
  get_data(e.target.value);
});

