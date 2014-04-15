angular.module('Edsc3Directives', [])
    .directive('chartHouseEnergies', ['House', 'Chart', function(House, Chart) {
        return function($scope, $element, $attrs) {

            $element[0].id = 'chart';
            $element[0].className += ' ' + 'chart';

            $scope.$watch("house.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                House.get({houseId: id, target: 'energies'}).$promise.then(function (d) {
                    Chart(d.data);
                });
            });
        };
    }])
    .directive('chartCityEnergies', ['City', 'Chart', function(City, Chart) {
        return function($scope, $element, $attrs) {

            $element[0].id = 'chart';
            $element[0].className += ' ' + 'chart';

            $scope.$watch("city.id", function (id) {
                if (typeof id === 'undefined') {
                    return;
                }
                City.get({cityId: id, target: 'energies'}).$promise.then(function (d) {
                    Chart(d.data);
                });
            });
        };
    }])
    .directive('chartCities', ['City', 'Chart', function(City, Chart) {
        return function($scope, $element, $attrs) {

            $element[0].id = 'chart';
            $element[0].className += ' ' + 'chart';

            City.get({target: 'energies'}).$promise.then(function (d) {
                Chart(d.data);
            });
        };
    }]);
