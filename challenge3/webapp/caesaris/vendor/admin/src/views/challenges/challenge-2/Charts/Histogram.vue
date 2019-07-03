<template lang="pug">
  section
    h3.chart-ttl {{ title }}
    p.chart-sub-ttl(v-if="subTtl") {{ subTtl }}
    .chart(:id="id", style="width: 100%;height: 450px;")
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { createHistOption, totalWatt, totalWattTime } from './StatChartHelper'
import * as echarts from 'echarts'

@Component
export default class Histogram extends Vue {
  @Prop({ default: 'Histogram' }) private id!: string
  @Prop({ default: [] }) private dataList!: totalWatt[][] | totalWattTime[][]
  @Prop({ default: () => [''] }) private dataSetLabel!: string[]
  @Prop({ default: '' }) private title!: string
  @Prop({ default: '' }) private subTtl!: string
  chart: echarts.ECharts | null = null

  mounted() {
    this.initChart()
    this.updateChart()
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

  @Watch('dataList')
  onValueChange(newValue: string, oldValue: string): void {
    this.updateChart()
  }

  updateChart() {
    if (this.chart && this.dataList.flat().length > 0) {
      this.chart.hideLoading()
      // const opt = createBarOption(this.energyData, this.tempData, this.labels, this.cities)
      const opt = createHistOption(this.dataList, this.dataSetLabel)
      this.chart.setOption(opt)
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
