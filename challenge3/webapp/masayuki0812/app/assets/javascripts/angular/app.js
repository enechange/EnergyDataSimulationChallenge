var edsc3App = angular.module('Edsc3App', ['ngRoute', 'Edsc3Controllers', 'Edsc3Services', 'ChartDirective']);

edsc3App.config(['$routeProvider',
    function($routeProvider) {
        $routeProvider.
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
