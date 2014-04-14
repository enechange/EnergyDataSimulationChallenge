var edsc3App = angular.module('Edsc3App', ['ngRoute', 'Edsc3Controllers', 'Edsc3Services', 'ChartDirective']);

edsc3App.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
            when('/cities', {
                templateUrl: 'partials/cityList.html',
                controller: 'CityListCtrl'
            }).
            when('/city/:cityId', {
                templateUrl: 'partials/cityDetail.html',
                controller: 'CityDetailCtrl'
            }).
            when('/houses', {
                templateUrl: 'partials/houseList.html',
                controller: 'HouseListCtrl'
            }).
            when('/house/:houseId', {
                templateUrl: 'partials/houseDetail.html',
                controller: 'HouseDetailCtrl'
            }).
            otherwise({
                redirectTo: 'houses'
            });
    }]);
