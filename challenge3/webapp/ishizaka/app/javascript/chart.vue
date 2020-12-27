<template>
  <div class="graph-wrap">
    <h3 class="title">世帯人数ごとの平均年間エネルギー生産</h3>
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
      labels:['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
      //データ詳細
      datasets: [{
        type: 'bar',
        label:'エネルギー生産（子供なし）',
        data: [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130],
        backgroundColor: 'blue'
      },
      {
        type: 'bar',
        label:'エネルギー生産（子供あり）',
        data: [20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130],
        backgroundColor: 'green'
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
