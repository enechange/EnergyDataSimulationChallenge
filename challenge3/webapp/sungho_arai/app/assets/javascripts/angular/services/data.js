var app = angular.module('CambridgeApp');

app.factory('Data', function($resource) {
  return $resource('/api/houses/:id/showData.json', {id: '@id'});
});
