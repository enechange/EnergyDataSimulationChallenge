var app = angular.module('CambridgeApp');

google.load("visualization", "1", {packages:["corechart"]});

app.controller('graphCtrl', [
  '$scope', 'Data', function($scope, Data) {

    // TODO(sungho.arai): Make the follwing simpler with ng-chart directive
    $scope.init = function(id)
    {
      $scope.house_id = id;
      var dataset = Data.query({id: $scope.house_id});
      dataset.$promise.then(function (dataset) {
        var titles = [["Date", "Energy Production", "Temperature", "DayLight"]];
        dataset.forEach(function(data){
          datapoint = new Array();
          datapoint.push(data["Date"]);
          datapoint.push(data["Production"]);
          datapoint.push(data["Temperature"]);
          datapoint.push(data["Daylight"]);
          titles.push(datapoint);
         });
        var data = google.visualization.arrayToDataTable(titles);
        var chart = {};
        var options = {};

        chart.data = data;
        chart.options = options;
        $scope.chart = chart;
        var graph = new google.visualization.LineChart(document.getElementById('chartdiv'));
        graph.draw($scope.chart.data, $scope.chart.options)
      });
    };
 }]);
