<template>
  <div class="about">
      <select
        name="city"
        v-model="selectedCity"
        v-on:change="filterCity"
        style="width:20vw;height:30px;font-size:15px;"
      >
      <option value='' disabled selected style='display:none;'>1.Please Select City</option>
        <option v-for="city in Cities" v-bind:key="city.name">{{ city.name }}</option>
      </select>
      <br />
      <select
        name="family"
        v-model="selectedFamily"
        v-on:change="filterFamily"
        style="width:20vw;height:30px;font-size:15px;margin-top:10px;"
      >
      <option value='' disabled selected style='display:none;'>2.Please Select Family</option>
        <option v-for="family in Families" v-bind:key="family.id">{{ family.name }}</option>
      </select>
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
      selectedCity: "",
      Cities: [
        { id: 1, name: "Cambridge" },
        { id: 2, name: "London" },
        { id: 3, name: "Oxford" }
      ],
      selectedFamily: "",
      Families: [],
      chartOptions: {
        chart: {
          type: "spline"
        },
        title: {
          text: "Monthly Data BY Family 2011-2013"
        },
        subtitle: {
          text: "Frontend Process Calculation"
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
        series: []
      }
    };
  },
  components: {
    highcharts: Chart
  },
  created: async function() {
    await this.getHousesData();
    await this.getEnergyProductionsData();
    this.collectPlotData();
  },
  methods: {
    async getHousesData() {
      await axios.get("http://localhost:3000/houses").then(response => {
        if (response.status != 200) {
          console.error(response);
          return;
        }
        this.housesData = response.data;
      });
    },
    async getEnergyProductionsData() {
      await axios
        .get("http://localhost:3000/energy_productions")
        .then(response => {
          if (response.status != 200) {
            console.error(response);
            return;
          }
          this.EnergyProductionsData = response.data;
        });
    },
    collectPlotData() {
      let allData = [];
      this.EnergyProductionsData.forEach(energy => {
        this.housesData.forEach(houses => {
          let unitData = [];
          if (houses.id == energy.house_id) {
            unitData = {
              city: houses.city,
              id: houses.id,
              name: houses.lastname,
              temperature: energy.temperature,
              daylight: energy.daylight,
              energyProduction: energy.energy_production,
              year: energy.year,
              month: energy.month
            };
            allData.push(unitData);
          }
        });
      });
      this.plotData = allData;
    },
    filterCity: function() {
      let city = this.selectedCity;
      let filtered = this.plotData.filter(function(value) {
        return value.city === city;
      });
      let values = [];
      let filteredFamily = filtered.filter(e => {
        if (values.indexOf(e["id"]) === -1) {
          values.push(e["id"]);
          return e;
        }
      });
      this.$set(this, "Families", filteredFamily);
    },
    filterFamily: function() {
      let family = this.selectedFamily;
      let filtered = this.plotData.filter(function(value) {
        return value.name === family;
      });
      let temperature = [];
      let daylight = [];
      let energyProduction = [];
      let xaxis = [];
      filtered.forEach(e => {
        temperature.push(e.temperature);
        daylight.push(e.daylight);
        energyProduction.push(e.energyProduction);
        xaxis.push(e.year + "-" + e.month);
      });
      let plot = [
        {
          name: "Temperature",
          data: temperature,
          color: "black",
          yAxis: 0
        },
        {
          name: "Daylight",
          data: daylight,
          color: "pink",
          yAxis: 1
        },
        {
          name: "Energy Production",
          data: energyProduction,
          color: "yellow",
          yAxis: 2
        }
      ];
      this.$set(this.chartOptions, "series", plot);
      this.$set(this.chartOptions.xAxis, "categories", xaxis);
    }
  }
};
</script>