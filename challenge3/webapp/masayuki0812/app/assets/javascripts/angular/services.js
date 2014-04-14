var edsc3Services = angular.module('Edsc3Services', ['ngResource']);
 
edsc3Services.factory('City', ['$resource',
  function($resource){
    return $resource('cities/:cityId.json', {cityId:'@id'}, {
        update: {method:'PUT'},
    });
  }]);

edsc3Services.factory('House', ['$resource',
  function($resource){
    return $resource('houses/:houseId/:target.json', {houseId:'@id'}, {
        update: {method:'PUT'},
    });
  }]);
