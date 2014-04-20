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

    var charts = {};

    return function (element, data, options) {
        options = options || {};

        element.id = options.id;
        element.className += ' ' + 'chart';

        var args = {
            bindto: '#' + options.id,
            data: {
                x: 'date',
                x_format: '%Y-%m',
                rows: data,
                type: options.type,
            },
            axis: {
                x: {
                    type: 'timeseries',
                    localtime: true,
                    tick: {
                        format: '%Y-%m',
                    }
                },
                y: {
                    tick: {
                        format: d3.format(',')
                    },
                    label: {
                        text: options.yLabel,
                        position: 'outer-middle'
                    }
                }
            },
            pie: {
                onmouseover: function (d) {
                    charts['chartBar'].focus(d.id);
                },
                onmouseout: function (d) {
                    charts['chartBar'].revert();
                }
            },
            legend: {
                position: options.legendPosition,
                show: typeof options.legend === 'undefined' ? true : options.legend,
                item: {
                    onmouseover: function (id) {
                        Object.keys(charts).forEach(function (key) {
                            charts[key].focus(id);
                        });
                    },
                    onmouseout: function () {
                        Object.keys(charts).forEach(function (key) {
                            charts[key].revert();
                        });
                    }
                }
            },
            zoom: {
//                enabled: true,
            }
        };

        if (options.y2) {
            args.data.types = {};
            args.data.types[options.y2.id] = options.y2.type;
            args.data.axes = {};
            args.data.axes[options.y2.id] = 'y2';
            args.axis.y2 = {
                show: true,
                label: {
                    text: options.y2.label,
                    position: 'outer-middle',
                }
            };
        }

        charts[options.id] = c3.generate(args);
    }
});