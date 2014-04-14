angular.module('ChartDirective', [])
    .directive('chart', ['House', function(House) {
        return function($scope, $element, $attrs) {

            $element[0].id = 'chart';

            $scope.$watch("house.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                House.get({houseId: id, target: 'energies'}).$promise.then(function (d) {
                    var chart = new google.visualization.ColumnChart(document.getElementById('chart'));
                    chart.draw(google.visualization.arrayToDataTable(d.data), { seriesType: 'bars' });
                });
            });
        };
    }]);
