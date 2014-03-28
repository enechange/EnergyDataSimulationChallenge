var app = angular.module('CambridgeApp');

app.controller('houseCtrl', [
  '$scope', 'House', function($scope, House) {
      return $scope.houses = House.query();
  }
]);
