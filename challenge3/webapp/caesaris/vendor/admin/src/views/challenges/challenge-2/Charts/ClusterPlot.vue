<template lang="pug">
  section
    h3.chart-ttl Energy Consumption Per Day
    p.chart-sub-ttl Clustered By KMeans From 2 To 4
    .chart(:id="id", style="width: 100%;height: 450px;")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import {
  getClusterStep,
  createPlotOption,
  getOption,
  totalWatt,
  totalWattTime,
} from './StatChartHelper'
import * as echarts from 'echarts'
import * as ecStat from 'echarts-stat'

@Component
export default class ClusterPlot extends Vue {
  @Prop({ default: 'ClusterPlot' }) private id!: string
  @Prop({ default: [] }) private dataList!: totalWattTime[] | totalWatt[]
  chart: echarts.ECharts | null = null

  mounted() {
    this.initChart()
    setTimeout(() => {
      this.updateChart().then(res => {
        if (this.chart) {
          this.chart.hideLoading()
        }
      })
    }, 500)
  }

  initChart() {
    const el = document.getElementById(this.id)
    this.chart = echarts.init(el as HTMLDivElement)
    this.chart.showLoading()
  }

  async updateChart() {
    if (this.chart) {
      const option = createPlotOption()
      const step = getClusterStep(this.dataList, 4) as any
      let result

      for (var i = 0; !(result = step.next()).isEnd; i++) {
        let options = option.options as any
        options.push(getOption(result as ecStat.clustering.Result, 4))
        let data = option.timeline.data as any
        data.push(i.toString())
      }
      this.chart.setOption(option)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";

.chart-ttl {
  margin-bottom: .7rem;
}
</style>
