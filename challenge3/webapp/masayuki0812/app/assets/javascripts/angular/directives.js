angular.module('Edsc3Directives', [])
    .directive('chartHouseEnergies', ['House', 'Chart', function(House, Chart) {
        return function($scope, $element, $attrs) {
            $scope.$watch("house.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                House.get({houseId: id, target: 'energies'}).$promise.then(function (d) {
                    Chart($element[0], d.data, {id: 'chart', type: 'bar', y2: {id: 'Daylight', type: 'line', label: 'Daylight'}, yLabel: 'Production'});
                });
            });
        };
    }])
    .directive('chartCityEnergies', ['City', 'Chart', function(City, Chart) {
        return function($scope, $element, $attrs) {
            $scope.$watch("city.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                City.get({cityId: id, target: 'energies'}).$promise.then(function (d) {
                    Chart($element[0], d.data, {id: 'chart', type: 'bar'});
                });
            });
        };
    }])
    .directive('chartCities', ['City', 'Chart', function(City, Chart) {
        return function($scope, $element, $attrs) {
            var pieChartDiv = document.createElement('div'),
                barChartDiv = document.createElement('div');

            pieChartDiv.id = 'chartPie';
            pieChartDiv.style.width = '25%';
            pieChartDiv.style.display = 'inline-block';
            barChartDiv.id = 'chartBar';
            barChartDiv.style.width = '75%';
            barChartDiv.style.display = 'inline-block';
            $element[0].appendChild(pieChartDiv);
            $element[0].appendChild(barChartDiv);

            City.get({target: 'energies'}).$promise.then(function (d) {
                Chart(pieChartDiv, d.data, {id: 'chartPie', type: 'pie', legend: false});
                Chart(barChartDiv, d.data, {id: 'chartBar', type: 'bar', legendPosition: 'right'});
            });
        };
    }]);
