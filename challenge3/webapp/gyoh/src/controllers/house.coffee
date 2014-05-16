houseControllers = angular.module "houseControllers", ["ngTable"]

houseControllers.controller "HouseListCtrl", ["$scope", "ngTableParams", "House"
  ($scope, ngTableParams, House) ->
    $scope.tableParams = new ngTableParams
      page: 1
      count: 10
    ,
      getData: ($defer, params) ->
        House.query (houses) ->
          params.total houses.length
          $defer.resolve(houses.slice (params.page() - 1) * params.count(), params.page() * params.count())

    $scope.searchFilter = (obj) ->
      re = new RegExp $scope.query, "i"
      !$scope.query or re.test(obj.Firstname) or re.test(obj.Lastname) or re.test(obj.City)
]