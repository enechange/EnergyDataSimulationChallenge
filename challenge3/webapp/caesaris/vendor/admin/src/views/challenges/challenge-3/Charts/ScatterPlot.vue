<template lang="pug">
  section
    h3.chart-ttl Scatter Plot
    .chart(:id="id", style="width: 100%;height: 400px;")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import * as echarts from 'echarts'
import { fetchGraphql } from '@/api/graphql.ts'
import { createScatterOption } from './ChartHelper'
const gql = String.raw // Dummy gql

@Component
export default class ScatterPlot extends Vue {
  @Prop({ default: 'ScatterPlot' }) private id!: string
  chart: echarts.ECharts | null = null

  beforeCreate() {
    console.log('ScatterPlot', 'beforeCreate')
    // fetchGraphql(
    //   gql`{ house(id: 1) { datasets { id } } }`
    // ).then(res => { this.graphRes = res })
  }

  beforeMount() {
    console.log('ScatterPlot', 'beforeMount')
  }

  mounted() {
    console.log('BarChart', 'mounted')
    this.initChart()
    this.updateChart()
  }

  beforeUpdate() {
    console.log('ScatterPlot', 'beforeUpdate')
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
      const opt = createScatterOption()
      this.chart.setOption(opt)
    }
  }
}
</script>
