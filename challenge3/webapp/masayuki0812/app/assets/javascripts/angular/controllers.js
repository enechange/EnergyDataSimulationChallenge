var edsc3Controllers = angular.module('Edsc3Controllers', []);

edsc3Controllers.controller('CityListCtrl', ['$scope', 'City', function ($scope, City) {

    $scope.cities = City.query();

    $scope.open = function (city) {
        location.href = '/#/city/' + city.id;
    };
    $scope.startNew = function () {
        $scope.creating = true;
        $scope.city = new City();
    };
    $scope.endNew = function () {
        $scope.creating = false;
    };
    $scope.new = function () {
        $scope.city.$save()
            .then(function (city) {
                $scope.cities.push($scope.city);
            })
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endNew();
            });
    };
}]);

edsc3Controllers.controller('CityDetailCtrl', ['$scope', '$routeParams', 'City', function($scope, $routeParams, City) {

    $scope.city = City.get({cityId: $routeParams.cityId});

    $scope.startEdit = function () {
        $scope.editing = true;
    };
    $scope.endEdit = function () {
        $scope.editing = false;
    };
    $scope.save = function () {
        City.update({cityId: $scope.city.id}, $scope.city)
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endEdit();
            });
    };
/*
    $scope.delete = function () {
        if (confirm('Are you sure?')) {
            $scope.city.$delete(
                function () {
                    location.href = '/#/cities'
                },
                function () {
                    // TODO: show error
                }
            );
        }
    };
*/
}]);

edsc3Controllers.controller('HouseListCtrl', ['$scope', 'House', function ($scope, House) {

    $scope.houses = House.query();

    $scope.open = function (house) {
        location.href = '/#/house/' + house.id;
    };
    $scope.startNew = function () {
        $scope.creating = true;
        $scope.house = new House();
    };
    $scope.endNew = function () {
        $scope.creating = false;
    };
    $scope.new = function () {
        $scope.house.$save()
            .then(function (house) {
                $scope.houses.push(house);
            })
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endNew();
            });
    };
}]);

edsc3Controllers.controller('HouseDetailCtrl', ['$scope', '$routeParams', 'House', function($scope, $routeParams, House) {

    $scope.house = House.get({houseId: $routeParams.houseId});
    //$scope.city = ...

    $scope.startEdit = function () {
        $scope.editing = true;
    };
    $scope.endEdit = function () {
        $scope.editing = false;
    };
    $scope.save = function () {
        House.update({houseId: $scope.house.id}, $scope.house)
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endEdit();
            });
    };
    $scope.delete = function () {
        if (confirm('Are you sure?')) {
            $scope.house.$delete()
                .then(function () {
                    location.href = '/#/houses'
                })
                .catch(function () {
                    // TODO: show error
                });
        }
    };
}]);
