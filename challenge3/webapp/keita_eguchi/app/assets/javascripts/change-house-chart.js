$(function(){
  function changeChart(data, kind){
  am4core.ready(function() {
    // Themes begin
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
    if (kind != 0) {
      createAxisAndSeries("house_energy_kind", "個人", false, "circle");
      createAxisAndSeries("same_condition_energy_kind", "同条件での平均", true, "triangle");
    } else {
      createAxisAndSeries("temperatures", "気温", false, "circle");
      createAxisAndSeries("daylights", "光量", false, "rectangle");
      createAxisAndSeries("energy_productions", "エネルギー生産量", true, "triangle");
    }
    // Add legend
    chart.legend = new am4charts.Legend();

    // Add cursor
    chart.cursor = new am4charts.XYCursor();

    // generate some random data, quite different range
    function generateChartData() {

      var chartData = [];
      var firstMonth = new Date('2011/7');

      for (var i = 0; i < data.labels.length  ; i++) {
        var newMonth = new Date(firstMonth);
        newMonth.setMonth(newMonth.getMonth() + i );
        if (kind != 0) {
          house_energy_kind = data.house_energy_kind[i]
          if (kind == 1){
            same_condition_energy_kind = data.same_condition_temperatures[i]
          }else if (kind == 2){
            same_condition_energy_kind = data.same_condition_daylights[i]
          }else if (kind == 3){
            same_condition_energy_kind = data.same_condition_energy_productions[i]
          }

          chartData.push({
            date: newMonth,
            house_energy_kind: house_energy_kind,
            same_condition_energy_kind: same_condition_energy_kind
          });

        } else {
          temperatures = data.same_condition_temperatures[i]
          daylights = data.same_condition_daylights[i]
          energy_productions = data.same_condition_energy_productions[i]

          chartData.push({
            date: newMonth,
            temperatures: temperatures,
            daylights: daylights,
            energy_productions: energy_productions
          });
        }


      }
      return chartData;
    }

    }); // end am4core.ready()
  }
  if(document.URL.match(/\/houses/)) {
    var kind = 0
    changeChart(gon.data, kind)

    $(document).on('change', 'select',function(e) {
      e.preventDefault();
      var house = $('select[name="chart[house]"] option:selected').val();
      var kind = $('select[name="chart[kind]"] option:selected').val();

      $.ajax({
        type:'get',
        url: '/houses',
        data: {house: house, kind: kind},
        dataType:'json',
      })
      .done(function(data){
        am4core.disposeAllCharts();
        changeChart(data, kind)
        $('.condition').find("td").eq(4).text(data.city);
        $('.condition').find("td").eq(5).text(data.num_of_people);
        $('.condition').find("td").eq(6).text(data.has_child);
        $('.condition').find("td").eq(7).text(data.same_condition_count);
      })
      .fail(function(){
        alert('データの読み込みに失敗しました')
      })
    })
  }
})