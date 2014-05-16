energyControllers = angular.module "energyControllers", ["ngTable"]

energyControllers.controller "EnergyListCtrl", ["$scope", "ngTableParams", "Energy"
  ($scope, ngTableParams, Energy) ->
    $scope.tableParams = new ngTableParams
      page: 1
      count: 10
    ,
      getData: ($defer, params) ->
        Energy.query (energies) ->
          params.total energies.length
          $defer.resolve(energies.slice (params.page() - 1) * params.count(), params.page() * params.count())
]

energyControllers.controller "HouseEnergyListCtrl", ["$scope", "$routeParams", "ngTableParams", "House", "Energy"
  ($scope, $routeParams, ngTableParams, House, Energy) ->
    House.query houseId: $routeParams.houseId, (house) ->
      $scope.house = house[0]

    Energy.query
      houseId: $routeParams.houseId
      (energies) ->
        data = _.map energies, (energy) ->
          date = new Date(parseInt(energy.Year, 10), parseInt(energy.Month, 10) - 1, 1)

          Date: date.getFullYear() + "-" + ("0" + (date.getMonth() + 1)).slice(-2)
          Temperature: energy.Temperature
          Daylight: energy.Daylight
          EnergyProduction: energy.EnergyProduction

        barChart = new Morris.Bar
          element: "barchart"
          data: data
          xkey: "Date"
          ykeys: ["EnergyProduction"]
          labels: ["Energy Production"]

        lineChart = new Morris.Line
          element: "linechart"
          data: data
          xkey: "Date"
          ykeys: ["Temperature", "Daylight"]
          labels: ["Temperature", "Daylight"]

        $scope.tableParams = new ngTableParams
          page: 1
          count: 10
        ,
          getData: ($defer, params) ->
            params.total energies.length
            $defer.resolve(energies.slice (params.page() - 1) * params.count(), params.page() * params.count())
]