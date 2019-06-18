<template lang="pug">
  section
    h3.chart-ttl Average Energy Production Per House
    .chart(:id="id", style="width: 100%;height:400px;")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { fetchGraphql } from '@/api/graphql.ts'
import * as echarts from 'echarts'
import { barData, createBarOption } from './ChartHelper'
const gql = String.raw // Dummy gql

const xAxisData = []
const data1 = []
const data2 = []
for (let i = 0; i < 100; i++) {
  xAxisData.push('类目' + i)
  data1.push((Math.sin(i / 5) * (i / 5 - 10) + i / 6) * 5)
  data2.push((Math.cos(i / 5) * (i / 5 - 10) + i / 6) * 5)
}

const option: echarts.EChartOption = {
  // title: {
  //   text: '柱状图动画延迟'
  // },
  legend: {
    data: ['bar', 'bar2'],
    align: 'left'
  },
  toolbox: {
    // y: 'bottom',
    feature: {
      magicType: {
        type: ['stack', 'tiled', 'line', 'bar'],
        title: {
          stack: 'Stack',
          tiled: 'Tiled',
          line: 'Line',
          bar: 'Bar'
        }
      },
      dataView: {
        title: 'Data View',
        lang: ['Chart', 'Close', 'Refresh']
      },
      saveAsImage: {
        title: 'Save',
        pixelRatio: 2
      }
    }
  },
  tooltip: {},
  xAxis: {
    data: xAxisData,
    silent: false,
    splitLine: {
      show: false
    }
  },
  yAxis: {},
  series: [{
    name: 'bar',
    type: 'bar',
    data: data1,
    animationDelay: (idx: number) => {
      return idx * 10
    }
  },
  {
    name: 'bar2',
    type: 'bar',
    data: data2,
    animationDelay: (idx: number) => {
      return idx * 10 + 100
    }
  }],
  animationEasing: 'elasticOut',
  animationDelayUpdate: (idx: number) => {
    return idx * 5
  }
}

@Component
export default class BarChart extends Vue {
  @Prop({ default: 'BarChart' }) private id!: string
  chart: echarts.ECharts | null = null
  cities: string[] = []
  labels: string[] = []
  energyData: barData = {}
  tempData: barData = {}
  daylightData: barData = {}

  beforeCreate() {
    console.log('BarChart', 'beforeCreate')
    // fetchGraphql(
    //   gql`{ house(id: 1) { datasets { id } } }`
    // ).then(res => res)
  }

  beforeMount() {
    console.log('BarChart', 'beforeMount')
  }

  mounted() {
    console.log('BarChart', 'mounted')
    this.fetchData().then(res => {
      console.log(res)
      this.cities = res['cities'].map((city: {name: string}) => city['name'])
      this.labels = res['dataSeries']['dateLabels']
      this.energyData = res['dataSeries']['houseEnergyProd']
      this.tempData = res['dataSeries']['temperature']
      this.daylightData = res['dataSeries']['daylight']
      this.initChart()
    })
  }

  beforeUpdate() {
    console.log('BarChart', 'beforeUpdate')
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
    // const opt = createBarOption(this.energyData, this.tempData, this.labels, this.cities)
    const opt = createBarOption(this.energyData, this.daylightData, this.labels, this.cities)
    this.chart.setOption(opt)
    // console.log(opt)
    // console.log(el)
    // console.log(this.chart)
  }

  async fetchData() {
    const query = gql`{
      cities { name },
      dataSeries { dateLabels, houseEnergyProd, daylight, temperature }
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
