edscApp = angular.module "edscApp", [
  "ngRoute"
  "houseControllers"
  "houseServices"
  "energyControllers"
  "energyServices"
]

edscApp.config ["$routeProvider"
  ($routeProvider) ->
    $routeProvider
      .when "/houses"
        templateUrl: "partials/house-list.html"
        controller: "HouseListCtrl"
      .when "/energies"
        templateUrl: "partials/energy-list.html"
        controller: "EnergyListCtrl"
      .when "/energies/:houseId"
        templateUrl: "partials/house-energy-list.html"
        controller: "HouseEnergyListCtrl"
      .otherwise
        redirectTo: "/houses"
]