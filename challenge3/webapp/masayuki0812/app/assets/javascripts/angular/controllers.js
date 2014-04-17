var edsc3Controllers = angular.module('Edsc3Controllers', []);

edsc3Controllers.controller('RootCtrl', ['$scope', function($scope) {
    $scope.$on('UpdateNavBarActive', function (event, target){
        if (target === 'house') {
            $scope.isActiveOnHouse = true;
            $scope.isActiveOnCity = false;
        } else {
            $scope.isActiveOnHouse = false;
            $scope.isActiveOnCity = true;
        }
    });
    $scope.$emit('UpdateNavBarActive', 'house');
}]);

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
                city.isCreated = true;
                $scope.city.count_house = 0
                $scope.city.total_energy_production = 0
                $scope.cities.push($scope.city);
            })
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endNew();
            });
    };

    $scope.$emit('UpdateNavBarActive', 'city');
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
        City.update($scope.city, function () {
            $scope.endEdit();
        }, function () {
            // TODO: show error
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

    $scope.$emit('UpdateNavBarActive', 'city');
}]);

edsc3Controllers.controller('HouseListCtrl', ['$scope', 'House', 'City', function ($scope, House, City) {

    $scope.houses = House.query();
    $scope.cities = City.query();

    $scope.open = function (house) {
        location.href = '/#/house/' + house.id;
    };
    $scope.startNew = function () {
        $scope.creating = true;
        $scope.house = new House();
        $scope.house.city_id = 1;
        $scope.house.num_of_people = 0;
        $scope.house.has_child = 0;
    };
    $scope.endNew = function () {
        $scope.creating = false;
    };
    $scope.new = function () {
        $scope.house.$save()
            .then(function (house) {
                house.isCreated = true;
                $scope.houses.push(house);
            })
            .catch(function () {
                // TODO: show error
            })
            .finally(function () {
                $scope.endNew();
            });
    };

    $scope.$emit('UpdateNavBarActive', 'house');
}]);

edsc3Controllers.controller('HouseDetailCtrl', ['$scope', '$routeParams', 'House', 'City', function($scope, $routeParams, House, City) {

    $scope.house = House.get({houseId: $routeParams.houseId});
    $scope.cities = City.query();

    $scope.startEdit = function () {
        $scope.editing = true;
    };
    $scope.endEdit = function () {
        $scope.editing = false;
    };
    $scope.save = function () {
        var selected = $scope.cities.filter(function (city) { return city.id === $scope.house.city.id; });
        if (selected.length > 0) {
            selected = selected[0];
            $scope.house.city_id = selected.id;
            $scope.house.city = selected;
            House.update($scope.house, function () {
                $scope.endEdit();
            }, function () {
                // TODO: show error
            });
        }
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

    $scope.$emit('UpdateNavBarActive', 'house');
}]);
