<script>
import { Pie } from 'vue-chartjs'
export default {
  name: 'PieChart',
  extends: Pie,
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
