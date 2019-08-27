(function() {

    var root = this;

    root.homeIndexFunc = function() {

        var summaryChart = function(data) {
            if (!Object.keys(data.report).length) {
                $('#sum_error_message').text('report does not exists.');
                return
            } else {
                $('#sum_error_message').text('');
            }

            $('#year').val(data.year);
            $('#month').val(data.month);

            Highcharts.chart('sum_graph_container', {
                chart: {
                    plotBackgroundColor: null,
                    plotBorderWidth: null,
                    plotShadow: false,
                    type: 'pie'
                },
                title: {
                    text: 'Summary energy production report'
                },
                tooltip: {
                    pointFormat: '{series.name}: <b>{point.y} / {point.percentage:.1f}%</b>'
                },
                plotOptions: {
                    pie: {
                        allowPointSelect: true,
                        cursor: 'pointer',
                        dataLabels: {
                            enabled: true,
                            format: '<b>{point.name}</b>: {point.y} / {point.percentage:.1f}%'
                        }
                    }
                },
                series: [{
                    name: 'Brands',
                    colorByPoint: true,
                    data: Object.keys(data.report).map(function(name) {
                        return {
                            name: name,
                            y: data.report[name]
                        }
                    })
                }]
            });
        };

        var getSummaryData = function() {
            var data = {};
            if ($('#year').val() !== '') {
                data.year = $('#year').val();
            }
            if ($('#month').val() !== '') {
                data.month = $('#month').val();
            }
            $.getJSON('/home/api/sum_graph_data.json', data, summaryChart)
        };

        $('#search_sum').click(getSummaryData);

        getSummaryData();

        var averageChart = function(data) {
            if (!Object.keys(data).length) {
                $('#avg_error_message').text('report does not exists.');
                return
            } else {
                $('#avg_error_message').text('');
            }

            Highcharts.chart('avg_graph_container', {
                chart: {
                    zoomType: 'xy'
                },
                title: {
                    text: 'Average energy production report',
                    align: 'left'
                },
                subtitle: {
                    text: 'Average value per household',
                    align: 'left'
                },
                xAxis: [{
                    categories: data.dates,
                    crosshair: true
                }],
                yAxis: [{ // Primary yAxis
                    labels: {
                        format: '{value}°C',
                        style: {
                            color: Highcharts.getOptions().colors[2]
                        }
                    },
                    title: {
                        text: 'Temperature',
                        style: {
                            color: Highcharts.getOptions().colors[2]
                        }
                    },
                    opposite: true
                }, { // Secondary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'EnergyProduction',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    },
                    labels: {
                        format: '{value}',
                        style: {
                            color: Highcharts.getOptions().colors[0]
                        }
                    }
                }, { // Tertiary yAxis
                    gridLineWidth: 0,
                    title: {
                        text: 'Daylight',
                        style: {
                            color: Highcharts.getOptions().colors[1]
                        }
                    },
                    labels: {
                        format: '{value} h',
                        style: {
                            color: Highcharts.getOptions().colors[1]
                        }
                    },
                    opposite: true
                }],
                tooltip: {
                    shared: true
                },
                legend: {
                    layout: 'vertical',
                    align: 'left',
                    x: 80,
                    verticalAlign: 'top',
                    y: 55,
                    floating: true,
                    backgroundColor:
                        Highcharts.defaultOptions.legend.backgroundColor || // theme
                        'rgba(255,255,255,0.25)'
                },
                series: [{
                    name: 'EnergyProduction',
                    type: 'column',
                    yAxis: 1,
                    data: data.energy_production_avg,
                    tooltip: {
                        valueSuffix: ''
                    }
                }, {
                    name: 'Daylight',
                    type: 'spline',
                    yAxis: 2,
                    data: data.daylight_avg,
                    marker: {
                        enabled: false
                    },
                    dashStyle: 'shortdot',
                    tooltip: {
                        valueSuffix: ' h'
                    }
                }, {
                    name: 'Temperature',
                    type: 'spline',
                    data: data.temperature_avg,
                    tooltip: {
                        valueSuffix: ' °C'
                    }
                }],
                responsive: {
                    rules: [{
                        condition: {
                            maxWidth: 500
                        },
                        chartOptions: {
                            legend: {
                                floating: false,
                                layout: 'horizontal',
                                align: 'center',
                                verticalAlign: 'bottom',
                                x: 0,
                                y: 0
                            }
                        }
                    }]
                }
            });
        };

        var getGraphData = function() {
            var data = {};
            if ($('#city').val() !== '') data.city = $('#city').val();
            if ($('#num_of_people').val() !== '') data.num_of_people = $('#num_of_people').val();
            if ($('#has_child').val() !== '') data.has_child = $('#has_child').val();
            $.getJSON('/home/api/avg_graph_data.json', data, averageChart);
        };

        $('#search_avg').click(getGraphData);

        getGraphData();
    };

}).call(this);
