angular.module('Edsc3Directives', [])
    .directive('chartHouseEnergies', ['House', function(House) {
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
    }])
    .directive('chartCityEnergies', ['City', function(City) {
        return function($scope, $element, $attrs) {

            $element[0].id = 'chart';

            $scope.$watch("city.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                City.get({cityId: id, target: 'energies'}).$promise.then(function (d) {
                    var chart = new google.visualization.ColumnChart(document.getElementById('chart'));
                    chart.draw(google.visualization.arrayToDataTable(d.data), { seriesType: 'bars' });
                });
            });
        };
    }]);
