<script>
import { Bar } from 'vue-chartjs'
export default {
  name: 'BarChart',
  extends: Bar,
  props: ['data', 'options'],
  mounted: function(){
    this.renderChart(this.data, this.options)
  },
  watch: {
    data: function(val) {
      this.renderChart(this.data, this.options)
    },
    options: function(val) {
      this.renderChart(this.data, this.options)
    }
  }
}
</script>
