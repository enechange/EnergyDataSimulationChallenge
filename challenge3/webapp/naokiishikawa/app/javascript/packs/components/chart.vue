<script>
import { Bar } from 'vue-chartjs'

export default Bar.extend({
  mounted: function (){
    this.renderChart({}, {
      scales: {
        xAxes: [{
          categoryPercentage: 0.9,
          barPercentage: 0.5
        }]
      }
    });
  },
  methods: {
    changeChartData: function(labels, datasets) {
      let chart = this._chart;
      chart.data.labels = labels;
      chart.data.datasets = datasets;
      chart.update();
    }
  }
});
</script>
