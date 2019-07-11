import * as _ from 'lodash'
import * as echarts from 'echarts'
import * as ecStat from 'echarts-stat'

function parseHistogramData(rawData: string) {
  const dataList = rawData.split(/\n|\r\n|\r|,/)
    .filter(r => r).map(parseFloat)
  return ecStat.histogram(dataList, 'squareRoot')
}

function createHistogramOptions(dataBins: ecStat.HistogramBins) {
  // console.log(dataBins);
  return {
    title: {
      // text: 'Histogram',
      // left: 'center',
      // top: 20,
    },
    color: ['rgb(25, 183, 207)'],
    grid: {
      left: '3%',
      right: '3%',
      bottom: '3%',
      containLabel: true,
    },
    xAxis: [{ type: 'value', scale: true }],
    yAxis: [{
      type: 'value',
    }],
    tooltip: {
      formatter: (data: any, foo: any, bar: any) => {
        // console.log(foo)
        // console.log(bar)
        const { value } = data
        return `Middle: ${value[0]}<br>Total: ${value[1]}`
        // return formatScatterTooltip([data] as tooltipData[], schema)
      },
    },
    series: [{
      name: 'height',
      type: 'bar',
      barWidth: '99.3%',
      label: {
        normal: {
          show: true,
          position: 'insideTop',
          formatter: (params: {value: string[]}) => {
            return params.value[1]
          },
        },
      },
      data: dataBins.data,
    }],
  }
}

export const histogramOptions = (rawData: string) => {
  return createHistogramOptions(parseHistogramData(rawData)) as echarts.EChartOption
}
