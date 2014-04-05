var app = angular.module('CambridgeApp');

google.load("visualization", "1", {packages:["corechart"]});

app.controller('graphCtrl', [
  '$scope', 'Data', function($scope, Data) {
    $scope.daylight_box = true; 
    $scope.temperature_box = true; 

    $scope.init = function(id)
    {
      $scope.house_id = id;
      $scope.date = [["Date"]];
      $scope.production = [["Energy Production"]];
      $scope.temperature = [["Temperature"]];
      $scope.daylight = [["DayLight"]];

      // TODO(sungho.arai): Rename variables for datapoints 
      var dataset = Data.query({id: $scope.house_id});
      dataset.$promise.then(function (dataset) {
        dataset.forEach(function(data){
          datapointDate = new Array();
          datapointDate.push(data["Date"]);
          $scope.date.push(datapointDate);

          datapointProduction = new Array();
          datapointProduction.push(data["Production"]);
          $scope.production.push(datapointProduction);

          datapointTemperature = new Array();
          datapointTemperature.push(data["Temperature"]);
          $scope.temperature.push(datapointTemperature);

          datapointDaylight = new Array();
          datapointDaylight.push(data["Daylight"]);
          $scope.daylight.push(datapointDaylight);
         });

        $scope.updateChart();
      });
    };
   
    // TODO(sungho.arai): Create datasets for each case in advance
    $scope.updateChart = function() {
      dataset = new Array();
      for (var i =0; i< $scope.date.length; i++) {
        datapoint = new Array();
        if ($scope.daylight_box && $scope.temperature_box) {
          datapoint.push($scope.date[i][0], $scope.production[i][0], $scope.daylight[i][0], $scope.temperature[i][0]);
        } else if ($scope.daylight_box) {
          datapoint.push($scope.date[i][0], $scope.production[i][0], $scope.daylight[i][0]);
        } else if ($scope.temperature_box) {
          datapoint.push($scope.date[i][0], $scope.production[i][0], $scope.temperature[i][0]);
        } else {
          datapoint.push($scope.date[i][0], $scope.production[i][0]);
        }
        dataset.push(datapoint);
      }
      var chart = {};
      var data = google.visualization.arrayToDataTable(dataset);
      var options = {
        seriesType: "bars"
      };

      chart.data = data;
      chart.options = options;
      $scope.chart = chart;

      var graph = new google.visualization.ColumnChart(document.getElementById('chartdiv'));
      graph.draw($scope.chart.data, $scope.chart.options)
    };
 }]);
