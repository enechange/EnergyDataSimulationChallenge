<template>
  <div>
    <form @submit.prevent="getEnergyData">
      <div class="form-group">
        <label>User ID</label>
        <input type="number" class="form-control" label="user-id" min="1" max="50" v-model="userId" placeholder="Please input user ID">
      </div>
      <div class="form-group">
          <label>Year</label>
          <select class="form-control" v-model="year">
            <option v-for="year in years">{{year}}</option>
          </select>
        </div>
      <button type="submit" class="btn btn-primary">Submit</button>
    </form>
    <div style="width: 600px">
      <chart ref="chart"></chart>
    </div>
  </div>
</template>

<script>
import Api from './api/api.js';
import Chart from './components/chart.vue';
const DEFAULT_USER_ID = 1;
const DEFAULT_YEAR = 2011;

export default {
  data: {
    userId: DEFAULT_USER_ID,
    average: {},
    years: [],
    year: DEFAULT_YEAR
  },
  mounted: function() {
    this.getAverage();
  },
  methods: {
    getEnergyData: function() {
      Api.getEnergyData(this.userId, this.year).then(response => {
        const labels  = response.data.labels;
        const dataset = response.data.data;
        const chartData = this.createChartData(labels, dataset);
        this.$refs.chart.changeChartData(labels, chartData);
      });
    },
    getAverage: function() {
      Api.getAverage().then(response => {
        this.average = response.data.average;
        this.years = response.data.years;
      });
    },
    createChartData: function(labels, dataset) {
      const averageDataset = labels.map(date => {
        return this.average[date];
      });
      const datasets = [
        {
          label: 'User Data',
          data: dataset
        },
        {
          label: 'Average',
          data: averageDataset,
          backgroundColor: '#f87979',
        }
      ];
      return datasets;
    }
  },
  components: {
    Chart
  }
};
</script>
