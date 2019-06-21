<template lang="pug">
  section
    h3.chart-ttl Energy Production
    p.chart-sub-ttl Plotted On Temperature And Daylight
    .chart(:id="id", style="width: 100%;height: 550px;")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import * as echarts from 'echarts'
import { fetchGraphql } from '@/api/graphql.ts'
import { createScatterOption, formatScatterGraphqlData } from './ChartHelper'
const gql = String.raw // Dummy gql

@Component
export default class ScatterPlot extends Vue {
  @Prop({ default: 'ScatterPlot' }) private id!: string
  chart: echarts.ECharts | null = null
  dataList: (number | string)[][][] = []
  labels: string[] = []
  daylightRange: number[] = []

  mounted() {
    this.initChart()
    this.fetchData().then(res => {
      const { labels, dataList, daylightRange } = formatScatterGraphqlData(res)
      this.labels = labels
      this.dataList = dataList
      this.daylightRange = daylightRange
      this.updateChart()
    })
  }

  beforeDestroy() {
    if (!this.chart) {
      return
    }
    this.chart.dispose()
    this.chart = null
  }

  initChart() {
    const el = document.getElementById(this.id)
    this.chart = echarts.init(el as HTMLDivElement)
    this.chart.showLoading()
  }

  updateChart() {
    if (this.chart) {
      this.chart.hideLoading()
      const opt = createScatterOption(this.dataList, this.labels, this.daylightRange)
      this.chart.setOption(opt)
    }
  }

  async fetchData() {
    const query = gql`{
      cities {
        name,
        datasets {
          dateStr,
          temperature,
          daylight,
          energyProduction,
          house { fullName }
        }
      }
    }`
    const res = await fetchGraphql(query)
    return res['data']
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";

.chart-ttl {
  margin-bottom: .7rem;
}
</style>
