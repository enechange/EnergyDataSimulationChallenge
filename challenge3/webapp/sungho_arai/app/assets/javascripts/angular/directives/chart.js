var app = angular.module('CambridgeApp');

app.directive('ngChart', function () {
    return function ($scope, elm, attrs) {
      var chart = new google.visualization.LineChart(document.getElementById('chartdiv'));
    };
});
