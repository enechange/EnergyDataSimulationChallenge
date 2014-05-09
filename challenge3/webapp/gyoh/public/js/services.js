var energyServices;

energyServices = angular.module("energyServices", ["ngResource"]);

energyServices.factory("Energy", [
  "$resource", function($resource) {
    return $resource("api/energies/:houseId", {}, {
      query: {
        method: "GET",
        params: {
          houseId: "list"
        },
        isArray: true
      }
    });
  }
]);

var houseServices;

houseServices = angular.module("houseServices", ["ngResource"]);

houseServices.factory("House", [
  "$resource", function($resource) {
    return $resource("api/houses/:houseId", {}, {
      query: {
        method: "GET",
        params: {
          houseId: "list"
        },
        isArray: true
      }
    });
  }
]);
