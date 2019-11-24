const select_box = document.getElementById('select_box');

const get_data = (url) => {
  axios.get('/' + url )
    .then(function (response) {
      scatter_chart(response.data);
      pie_chart(response.data);
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


const pie_chart = (dataArray) => {
  const ctx = document.getElementById('myChart2').getContext('2d');
  const labelArray = dataArray.map((value) => {
    return value.label
  });
  const colorArray = dataArray.map((value) => {
    return value.borderColor
  });
  const newDataArray = dataArray.map((value) => {
    let data = 0;
    value.data.forEach((value) => {
      data = data + value.y;
    });
    return data
  });

  new Chart(ctx, {
    type: 'pie',
    data: {
        labels: labelArray,
        datasets: [{
          data: newDataArray,
          backgroundColor: colorArray
        }],
    },
  });
};

window.onload = () => {
  get_data('all');
};

select_box.addEventListener('change', (e) => {
  get_data(e.target.value);
});

