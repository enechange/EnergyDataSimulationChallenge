energyServices = angular.module "energyServices", ["ngResource"]

energyServices.factory "Energy", ["$resource"
  ($resource) ->
    $resource "api/energies/:houseId", {},
      query:
        method: "GET"
        params:
          houseId: "list"
        isArray: true
]