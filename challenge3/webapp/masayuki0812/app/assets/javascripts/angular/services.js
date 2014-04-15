var edsc3Services = angular.module('Edsc3Services', ['ngResource']);
 
edsc3Services.factory('City', ['$resource',
  function($resource){
    return $resource('cities/:cityId/:target.json', {cityId:'@id'}, {
        update: {method:'PUT'},
    });
  }]);

edsc3Services.factory('House', ['$resource',
  function($resource){
    return $resource('houses/:houseId/:target.json', {houseId:'@id'}, {
        update: {method:'PUT'},
    });
  }]);

edsc3Services.factory('Chart', function () {
    return function (data) {
        c3.generate({
            padding: {
                left: 50,
            },
            data: {
                x: 'date',
                x_format: '%Y-%m',
                rows: data,
                type: 'bar',
            },
            axis: {
                x: {
                    type: 'timeseries',
                    tick: {
                        format: '%Y-%m',
                    }
                },
                y: {
                    tick: {
                        format: d3.format(',')
                    }
                }
            },
            zoom: {
//                enabled: true,
            }
        });
    }
});