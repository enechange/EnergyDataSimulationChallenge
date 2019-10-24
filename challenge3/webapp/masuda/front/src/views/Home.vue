<template>
  <div class="about">
    <highcharts :options="chartOptions"></highcharts>
  </div>
</template>
<script>
import { Chart } from "highcharts-vue";
import axios from "axios";
export default {
  name: "graph1",
  data() {
    return {
      chartOptions: {
        chart: {
          type: "spline"
        },
        title: {
          text: "Average Data BY City 2011-2013"
        },
        subtitle: {
          text: "Backend Process Calculation"
        },
        xAxis: {
          categories: ""
        },
        yAxis: [
          {
            title: {
              text: "Temperature"
            }
          },
          {
            title: {
              text: "Daylight"
            },
            opposite: true
          },
          {
            title: {
              text: "Energy Production"
            },
            opposite: true
          }
        ],
        legend: {
          layout: "vertical",
          align: "left",
          verticalAlign: "middle"
        },
        series: [
          {
            name: "Cambridge-Temperature",
            data: [],
            color: "red",
            yAxis: 0
          },
          {
            name: "London-Temperature",
            data: [],
            color: "green",
            yAxis: 0
          },
          {
            name: "Oxford-Temperature",
            data: [],
            color: "blue",
            yAxis: 0
          },
          {
            name: "Cambridge-Daylight",
            data: [],
            color: "red",
            dashStyle: "Dash",
            yAxis: 1
          },
          {
            name: "London-Daylight",
            data: [],
            color: "green",
            dashStyle: "Dash",
            yAxis: 1
          },
          {
            name: "Oxford-Daylight",
            data: [],
            color: "blue",
            dashStyle: "Dash",
            yAxis: 1
          },
          {
            name: "Cambridge-Energy Production",
            data: [],
            color: "red",
            dashStyle: "Dot",
            yAxis: 2
          },
          {
            name: "London-Energy Production",
            data: [],
            color: "green",
            dashStyle: "Dot",
            yAxis: 2
          },
          {
            name: "Oxford-Energy Production",
            data: [],
            color: "blue",
            dashStyle: "Dot",
            yAxis: 2
          }
        ]
      }
    };
  },
  components: {
    highcharts: Chart
  },
  created: function() {
    this.getApiDataAndCalc("temperature");
    this.getApiDataAndCalc("daylight");
    this.getApiDataAndCalc("energy_production");
  },
  methods: {
    getApiDataAndCalc(param) {
      axios
        .get("http://localhost:3000/average_by_cities?select=" + param)
        .then(response => {
          if (response.status != 200) {
            console.error(response);
            return;
          }
          let Cambridge = [];
          let London = [];
          let Oxford = [];
          let xaxis = [];
          response.data.forEach(obj => {
            let label;
            switch (obj.city) {
              case "Cambridge":
                Cambridge.push(obj.avg);
                label = obj.year + "-" + obj.month;
                xaxis.push(label);
                break;
              case "London":
                London.push(obj.avg);
                break;
              case "Oxford":
                Oxford.push(obj.avg);
                break;
              default:
                break;
            }
          });
          switch (param) {
            case "temperature":
              this.$set(this.chartOptions.series[0], "data", Cambridge);
              this.$set(this.chartOptions.series[1], "data", London);
              this.$set(this.chartOptions.series[2], "data", Oxford);
              break;
            case "daylight":
              this.$set(this.chartOptions.series[3], "data", Cambridge);
              this.$set(this.chartOptions.series[4], "data", London);
              this.$set(this.chartOptions.series[5], "data", Oxford);
              break;
            case "energy_production":
              this.$set(this.chartOptions.series[6], "data", Cambridge);
              this.$set(this.chartOptions.series[7], "data", London);
              this.$set(this.chartOptions.series[8], "data", Oxford);
              break;
            default:
              break;
          }
          this.$set(this.chartOptions.xAxis, "categories", xaxis);
        });
    }
  }
};
</script>