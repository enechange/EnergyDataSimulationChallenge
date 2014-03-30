var app = angular.module('CambridgeApp');

app.factory('Data', function($resource) {
  return $resource('/api/houses/:id/showData.json', {id: '@id'});
  //return $resource('/api/houses/43/showData.json');
  //return [
  //    ['Year', 'Sales', 'Expenses'],
  //    ['2004', 1000, 400],
  //    ['2005', 1170, 460],
  //  ];
});
