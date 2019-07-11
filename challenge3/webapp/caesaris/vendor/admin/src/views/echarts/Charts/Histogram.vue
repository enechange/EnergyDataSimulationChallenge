<template lang="pug">
  section
    input-dialog(
      :on-open-flg='openDialogFlg', @data-change='onDataChange',
      placeholder='0.23\n0.13\n0.12',
    )
    h3.chart-ttl
      |Histogram According to Square-root Choice
      el-button.input-data-btn(
        @click='openDataInputDialog()',
        type='text', icon='el-icon-s-data'
      ) Input Data!
    .chart(:id='id', style='width: 100%;height: 450px;')
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import InputDialog from './InputDialog.vue'
import * as echarts from 'echarts'

@Component({
  components: { InputDialog },
})
export default class Histogram extends Vue {
  @Prop({ default: 'histogram-playground' }) private id!: string
  private chart: echarts.ECharts | null = null
  private chartData: string | null = null
  private openDialogFlg = 0

  openDataInputDialog() {
    this.openDialogFlg = Date.now()
  }

  mounted() {
    this.initChart()
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

  onDataChange(data: string) {
    console.log('dataChange', data)
    this.updateChart()
  }
  // @Watch('chartData')
  // onValueChange(newValue: string, oldValue: string): void {
  //   this.updateChart()
  // }

  updateChart() {
    if (this.chart) {
      this.chart.hideLoading()
      // const opt = createHistOption(this.dataList, this.dataSetLabel)
      // this.chart.setOption(opt)
    }
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";

.chart-ttl {
  margin-bottom: .7rem;
}

.input-data-btn {
  float: right;
  margin-top: -5px;
  margin-left: -105px;
}

@media (max-width: 800px) {
  .input-data-btn {
    display: block;
    margin-left: calc(100% - 100px);
  }
}
</style>
