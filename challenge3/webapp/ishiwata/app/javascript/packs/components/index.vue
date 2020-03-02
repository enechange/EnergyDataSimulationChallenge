<template>
  <div>
    <h3>棒グラフを描画する</h3>
    <BarChart/>
  </div>
</template>

<script>
// インポート
import { Bar } from 'vue-chartjs'

var BarChart = {
  extends: Bar,
  mounted () {
    this.renderChart({
      //ラベル
      labels:["１月","２月","３月","４月","5月"],
      //データ詳細
      datasets: [{
        //データタイトル
        label:'勉強時間',
        //データ
        data: [20,30,40,50,10]
      }]
    });
  }
}

export default {
  name: 'Test',
  components: {
    BarChart
  }
}

</script>
