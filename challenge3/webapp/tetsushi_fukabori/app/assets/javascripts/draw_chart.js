$(window).load(function(){
  draw_scatter();
  draw_line();
});

$(function() {
  $('#graph_key').on('change', function () {
    var key = $(this).val();
    draw_scatter(key);
    draw_line(key);
  });
});

function get_colors(size){
  if(size === 1){
    return ['#888888']
  } else {
    return palette('mpn65', size).map(function (hex) { return '#' + hex; });
  }
}

function draw_scatter(key){
  $.ajax({
    type: 'GET',
    url: '/scatter?key=' + key,
    dataType: 'JSON',
    success: function(data) {
      var colors = get_colors(data.length);
      var datasets = data.map(function (dat, i, a) {
        return {
          label: dat.label,
          data: dat.data,
          backgroundColor: colors[i] + '11',
          borderColor: colors[i]
        };
      });

      // 描画位置の取得
      $("canvas#scatter_chart").remove();
      $("div#scatter_area").append('<canvas id="scatter_chart" width="500" height="500"></canvas>');
      var context = $("#scatter_chart").get(0).getContext("2d");
      // チャートデータの生成
      var myChart = new Chart(context, {
        type: 'scatter',
        data: { datasets: datasets },
        // チャートのオプション設定
        options: {
          responsive: false, // レスポンシブ設定
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
                labelString: 'Production'
              }
            }]
          }
        }
      });
    }
  });
}

function draw_line(key){
  $.ajax({
    type: 'GET',
    url: '/line?key=' + key,
    dataType: 'JSON',
    success: function(data) {
      var colors = get_colors(data.datasets.length);
      var datasets = data.datasets.map(function (dat, i, a) {
        return {
          label: dat.label,
          data: dat.data,
          backgroundColor: 'rgba(0, 0, 0, 0)',
          borderColor: colors[i]
        };
      });

      // 描画位置の取得
      $("canvas#line_chart").remove();
      $("div#line_area").append('<canvas id="line_chart" width="1500" height="500"></canvas>');
      var context = $("#line_chart").get(0).getContext("2d");
      // チャートデータの生成
      var myChart = new Chart(context, {
        type: 'line',
        data: {
          labels: data.labels,
          datasets: datasets
        },
        // チャートのオプション設定
        options: {
          responsive: true, // レスポンシブ設定
          maintainAspectRatio: false, // アスペクト比の維持設定
          elements: {
            line: {
              tension: 0, // ベジェ曲線を無効にする
            }
          },
          scales: {
            xAxes: [{
              scaleLabel: {
                display: true,
                labelString: 'Date'
              }
            }],
            yAxes: [{
              ticks: {
                beginAtZero: true
              },
              scaleLabel: {
                display: true,
                labelString: 'Average Production'
              }
            }]
          }
        }
      });
    }
  });
}