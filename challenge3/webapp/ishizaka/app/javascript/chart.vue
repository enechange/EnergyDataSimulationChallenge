<template>
  <div class="graph-wrap">
    <BarChart/>
  </div>
</template>

<script>
import { Bar } from 'vue-chartjs'

var BarChart = {
  extends: Bar,
  mounted () {
    this.renderChart({
      //ラベル
      labels: dates,
      //データ詳細
      datasets: [{
        type: 'bar',
        label:'Energy Production',
        data: [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130],
        backgroundColor: 'blue'
      }]
    });
  }
}

export default {
  name: 'Chart',
  components: {
    BarChart
  }
} 
</script>

<style scoped>
.graph-wrap {
  width: 85%;
  height: 40%;
  margin: 0 auto;
}

.graph-wrap > .title {
  font-size: 24px;
  text-align: center;
  color: red;
}
</style>
