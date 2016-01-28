// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function(){
  var city_select = $("#city_id");
  var time_chart;
  var daylight_chart;
  var temperature_chart;

  city_select.change(function() {
    renderCityChart();
  });

  setChartData = function(data) {
    var xs = {};
    var time_columns = {};
    var daylight_columns = {};
    var temperature_columns = {};

    $.each(data, function(i, energy) {
      var house_label  = "house" + energy.house_id;
      var x_label = "x" + energy.house_id;

      if (!xs[house_label]) {
        xs[house_label] = x_label;

        time_columns[energy.house_id] = {
          x: [x_label, energy.recorded_at],
          y: [house_label, energy.energy_production]
        };

        daylight_columns[energy.house_id] = {
          x: [x_label, energy.daylight],
          y: [house_label, energy.energy_production]
        };

        temperature_columns[energy.house_id] = {
          x: [x_label, energy.temperature],
          y: [house_label, energy.energy_production]
        }
      } else {
        time_columns[energy.house_id].x.push(energy.recorded_at);
        time_columns[energy.house_id].y.push(energy.energy_production);

        daylight_columns[energy.house_id].x.push(energy.daylight);
        daylight_columns[energy.house_id].y.push(energy.energy_production);

        temperature_columns[energy.house_id].x.push(energy.temperature);
        temperature_columns[energy.house_id].y.push(energy.energy_production);
      }
    });

    time_columns = $.map(time_columns, function(n, i) {
      return [n.x, n.y];
    });

    daylight_columns = $.map(daylight_columns, function(n, i) {
      return [n.x, n.y];
    });

    temperature_columns = $.map(temperature_columns, function(n, i) {
      return [n.x, n.y];
    });

    return {
      xs: xs,
      time_columns: time_columns,
      daylight_columns: daylight_columns,
      temperature_columns: temperature_columns
    };
  }

  renderCityChart = function() {
    var city_id = city_select.val();

    $.get("/cities/" + city_id + "/energies", function(data) {
      $.when(
        setChartData(data)
      ).done(function(chart_data) {
        time_chart = c3.generate({
          bindto: "#time-chart",
          data: {
            xFormat: '%Y-%m-%d',
            columns: chart_data.time_columns,
            xs: chart_data.xs
          },
          axis: {
            x: {
              type: 'timeseries',
              tick: { format: '%Y-%m' },
              label: 'time'
            },
            y: {label: 'energy production'}
          }
        });

        daylight_chart = c3.generate({
          bindto: "#daylight-chart",
          data: {
            xs: chart_data.xs,
            columns: chart_data.daylight_columns,
            type: 'scatter',
          },
          axis: {
            x: {label: 'daylight'},
            y: {label: 'energy production'}
          }
        });

        temperature_chart = c3.generate({
          bindto: "#temperature-chart",
          data: {
            xs: chart_data.xs,
            columns: chart_data.temperature_columns,
            type: 'scatter'
          },
          axis: {
            x: {label: 'temperature'},
            y: {label: 'energy production'}
          }
        });
      });
    });
  }

  renderCityChart();
});
