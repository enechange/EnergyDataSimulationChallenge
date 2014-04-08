var app = angular.module('CambridgeApp');

app.controller('houseCtrl', [
  '$scope', 'House', 'ngTableParams', '$filter', function($scope, House, ngTableParams, $filter) {
    var data = House.query();
    data.$promise.then(function (houses) {
      $scope.tableParams = new ngTableParams({
        page: 1,            // show first page
        count: 25,          // count per page
        sorting: {
            "city": 'asc'     // initial sorting
        }
      }, {
        total: houses.length,
        getData: function($defer, params) {
          var orderedHouses = params.sorting() ?
                                $filter('orderBy')(houses, params.orderBy()) :
                                houses;
          $defer.resolve(orderedHouses.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        }
      });
    });
  }
]);
