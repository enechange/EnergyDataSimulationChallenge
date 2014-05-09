var energyControllers;

energyControllers = angular.module("energyControllers", ["ngTable"]);

energyControllers.controller("EnergyListCtrl", [
  "$scope", "ngTableParams", "Energy", function($scope, ngTableParams, Energy) {
    return $scope.tableParams = new ngTableParams({
      page: 1,
      count: 10
    }, {
      getData: function($defer, params) {
        return Energy.query(function(energies) {
          params.total(energies.length);
          return $defer.resolve(energies.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        });
      }
    });
  }
]);

energyControllers.controller("HouseEnergyListCtrl", [
  "$scope", "$routeParams", "ngTableParams", "House", "Energy", function($scope, $routeParams, ngTableParams, House, Energy) {
    House.query({
      houseId: $routeParams.houseId
    }, function(house) {
      return $scope.house = house[0];
    });
    return Energy.query({
      houseId: $routeParams.houseId
    }, function(energies) {
      var barChart, data, lineChart;
      data = _.map(energies, function(energy) {
        var date;
        date = new Date(parseInt(energy.Year, 10), parseInt(energy.Month, 10) - 1, 1);
        return {
          Date: date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2),
          Temperature: energy.Temperature,
          Daylight: energy.Daylight,
          EnergyProduction: energy.EnergyProduction
        };
      });
      barChart = new Morris.Bar({
        element: "barchart",
        data: data,
        xkey: "Date",
        ykeys: ["EnergyProduction"],
        labels: ["Energy Production"]
      });
      lineChart = new Morris.Line({
        element: "linechart",
        data: data,
        xkey: "Date",
        ykeys: ["Temperature", "Daylight"],
        labels: ["Temperature", "Daylight"]
      });
      return $scope.tableParams = new ngTableParams({
        page: 1,
        count: 10
      }, {
        getData: function($defer, params) {
          params.total(energies.length);
          return $defer.resolve(energies.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        }
      });
    });
  }
]);

var houseControllers;

houseControllers = angular.module("houseControllers", ["ngTable"]);

houseControllers.controller("HouseListCtrl", [
  "$scope", "ngTableParams", "House", function($scope, ngTableParams, House) {
    $scope.tableParams = new ngTableParams({
      page: 1,
      count: 10
    }, {
      getData: function($defer, params) {
        return House.query(function(houses) {
          params.total(houses.length);
          return $defer.resolve(houses.slice((params.page() - 1) * params.count(), params.page() * params.count()));
        });
      }
    });
    return $scope.searchFilter = function(obj) {
      var re;
      re = new RegExp($scope.query, "i");
      return !$scope.query || re.test(obj.Firstname) || re.test(obj.Lastname) || re.test(obj.City);
    };
  }
]);
