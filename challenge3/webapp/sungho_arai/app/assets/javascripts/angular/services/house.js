var app = angular.module('CambridgeApp');

app.factory('House', function($resource) {
  return $resource('/api/houses.json');
});
