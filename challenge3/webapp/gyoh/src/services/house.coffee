houseServices = angular.module "houseServices", ["ngResource"]

houseServices.factory "House", ["$resource"
  ($resource) ->
    $resource "api/houses/:houseId", {},
      query:
        method: "GET"
        params:
          houseId: "list"
        isArray: true
]