<template lang="pug">
  section
    h3.chart-ttl Average Energy Production Per House
    .chart(:id="id", style="width: 100%;height: 400px;")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { fetchGraphql } from '@/api/graphql.ts'
import * as echarts from 'echarts'
import { barData, createBarOption } from './ChartHelper'
const gql = String.raw // Dummy gql

@Component
export default class BarChart extends Vue {
  @Prop({ default: 'BarChart' }) private id!: string
  chart: echarts.ECharts | null = null
  cities: string[] = []
  labels: string[] = []
  energyData: barData = {}
  // tempData: barData = {}
  daylightData: barData = {}

  mounted() {
    console.log('BarChart', 'mounted')
    this.initChart()
    this.fetchData().then(res => {
      this.cities = res['cities'].map((city: {name: string}) => city['name'])
      this.labels = res['dataSeries']['dateLabels']
      this.energyData = res['dataSeries']['houseEnergyProd']
      // this.tempData = res['dataSeries']['temperature']
      this.daylightData = res['dataSeries']['daylight']
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
      // const opt = createBarOption(this.energyData, this.tempData, this.labels, this.cities)
      const opt = createBarOption(this.energyData, this.daylightData, this.labels, this.cities)
      this.chart.setOption(opt)
    }
  }

  async fetchData() {
    const query = gql`{
      cities { name },
      dataSeries {
        dateLabels,
        houseEnergyProd,
        daylight,
        # temperature
      }
    }`
    const res = await fetchGraphql(query)
    return res['data']
  }
}
</script>

<style lang="scss" scoped>
.chart-ttl {
  text-align: center;
  margin-top: 0;
  margin-bottom: 1.5rem;
  font-size: 1.5rem;
  color: #333;
}
</style>
