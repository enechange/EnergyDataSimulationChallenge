var app = angular.module('CambridgeApp', []);

//TODO(sungho.arai): Move this to app/assets and add ng-resource
app.controller('houseCtrl', [
  '$scope', function($scope) {
      $scope.houses = [
          {"name": "nakamura", "point": "10"},
          {"name": "hoge", "point": "20"},
          {"name": "ugaugo", "point": "200"},
      ];
  }
]);
