$(function(){
  function changeChart(data,city,kind){
    am4core.ready(function() {
      // Themes begin
      am4core.useTheme(am4themes_dark);
      am4core.useTheme(am4themes_animated);
      // Themes end

      // Create chart instance
      var chart = am4core.create("chartdiv", am4charts.XYChart);

      // Increase contrast by taking evey second color
      chart.colors.step = 2;

      // Add data
      chart.data = generateChartData();

      // Create axes
      var dateAxis = chart.xAxes.push(new am4charts.DateAxis());
      dateAxis.renderer.minGridDistance = 50;

      // Create series
      function createAxisAndSeries(field, name, opposite, bullet) {
        var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
        if(chart.yAxes.indexOf(valueAxis) != 0){
          valueAxis.syncWithAxis = chart.yAxes.getIndex(0);
        }

        var series = chart.series.push(new am4charts.LineSeries());
        series.dataFields.valueY = field;
        series.dataFields.dateX = "date";
        series.strokeWidth = 2;
        series.name = name;
        series.tooltipText = "{name}: [bold]{valueY}[/]";
        series.tensionX = 0.8;
        series.showOnInit = true;

        var interfaceColors = new am4core.InterfaceColorSet();

        switch(bullet) {
          case "triangle":
            var bullet = series.bullets.push(new am4charts.Bullet());
            bullet.width = 12;
            bullet.height = 12;
            bullet.horizontalCenter = "middle";
            bullet.verticalCenter = "middle";

            var triangle = bullet.createChild(am4core.Triangle);
            triangle.stroke = interfaceColors.getFor("background");
            triangle.strokeWidth = 2;
            triangle.direction = "top";
            triangle.width = 12;
            triangle.height = 12;
            break;
          case "rectangle":
            var bullet = series.bullets.push(new am4charts.Bullet());
            bullet.width = 10;
            bullet.height = 10;
            bullet.horizontalCenter = "middle";
            bullet.verticalCenter = "middle";

            var rectangle = bullet.createChild(am4core.Rectangle);
            rectangle.stroke = interfaceColors.getFor("background");
            rectangle.strokeWidth = 2;
            rectangle.width = 10;
            rectangle.height = 10;
            break;
          default:
            var bullet = series.bullets.push(new am4charts.CircleBullet());
            bullet.circle.stroke = interfaceColors.getFor("background");
            bullet.circle.strokeWidth = 2;
            break;
        }

        valueAxis.renderer.line.strokeOpacity = 1;
        valueAxis.renderer.line.strokeWidth = 2;
        valueAxis.renderer.line.stroke = series.stroke;
        valueAxis.renderer.labels.template.fill = series.stroke;
        valueAxis.renderer.opposite = opposite;
      }
      if( city == 'All' && kind != 0 ){
        createAxisAndSeries("london", "ロンドン", false, "circle");
        createAxisAndSeries("cambridge", "ケンブリッジ", false, "rectangle");
        createAxisAndSeries("oxford", "オックスフォード", true, "triangle");
      }else if(city == 'All' || kind == 0 ){
        createAxisAndSeries("temperatures", "気温", false, "circle");
        createAxisAndSeries("daylights", "光量", false, "rectangle");
        createAxisAndSeries("energy_productions", "エネルギー生産量", true, "triangle");
      }else{
        createAxisAndSeries("target_citykinds", city, false, "circle");
        createAxisAndSeries("all_citykinds", "全エリアの平均", false, "triangle");
      }

      // Add legend
      chart.legend = new am4charts.Legend();

      // Add cursor
      chart.cursor = new am4charts.XYCursor();

      // generate some random data, quite different range
      function generateChartData() {

        var chartData = [];
        var month = new Date('2011/7');
        for (var i = 0; i < data.labels.length  ; i++) {
          if(city == 'All' && kind != 0 ){

            london = data.london[i]
            cambridge = data.cambridge[i]
            oxford = data.oxford[i]

            chartData.push({
              date: month,
              london: london,
              cambridge: cambridge,
              oxford: oxford
            });

          }else if ( city == 'All' || kind == 0 ){
            temperatures = data.temperatures[i]
            daylights = data.daylights[i]
            energy_productions = data.energy_productions[i]

            chartData.push({
              date: month.setMonth(month.getMonth() + 1 ),
              temperatures: temperatures,
              daylights: daylights,
              energy_productions: energy_productions
            });

          }else{
            target_citykinds= data.target_citykinds[i]
            all_citykinds = data.all_citykinds[i]

            chartData.push({
              date: month,
              target_citykinds: target_citykinds,
              all_citykinds: all_citykinds
            });
          }

        }
        console.log(chartData)
        return chartData;

      }

      });
  }
  if(document.URL.match(/\/$/)) {
    var city = 'All'
    var kind = 0
    changeChart(gon.data, city ,kind)

    $(document).on('change', 'select',function(e) {
      e.preventDefault();
      var city = $('select[name="chart[city]"] option:selected').val();
      var kind = $('select[name="chart[kind]"] option:selected').val();

      $.ajax({
        type:'get',
        url: '/energies',
        data: {city: city, kind: kind},
        dataType:'json',
      })
      .done(function(data){
        am4core.disposeAllCharts();
        changeChart(data, city, kind)
      })
      .fail(function(){
        alert('データの読み込みに失敗しました')
      })
    })
  }
})