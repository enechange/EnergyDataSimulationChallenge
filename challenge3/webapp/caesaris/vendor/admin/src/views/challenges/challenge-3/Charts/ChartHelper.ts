import * as echarts from 'echarts'
import * as _ from 'lodash'

export interface barData {
  [key: string]: {
    [label: string]: number[]
  },
}

export const createBarOption = (barData: barData, lineData: barData, labels: string[], cities: string[]) => {
  console.log(barData, lineData, labels, cities)
  const xAxisData = labels
  const barDataList: (number | null)[][] = []
  const lineDataList: (number | null)[][] = []
  cities.forEach((city, i) => {
    barDataList[i] = []
    lineDataList[i] = []
    for (const label of xAxisData) {
      if (barData[city][label] && barData[city][label][1]) {
        barDataList[i].push(barData[city][label][1])
      } else {
        barDataList[i].push(null)
      }
      if (lineData[city][label] && lineData[city][label][1]) {
        lineDataList[i].push(lineData[city][label][1])
      } else {
        lineDataList[i].push(null)
      }
    }
  })

  const option: echarts.EChartOption = {
    // title: {},
    legend: {
      data: cities,
      align: 'left'
    },
    dataZoom: [
      {
        show: true,
        // start: 50,
        // end: 100
      },
      {
        show: true,
        type: 'inside',
      },
      {
        show: true,
        yAxisIndex: 0,
        filterMode: 'empty',
        left: '93%'
      }
    ],
    toolbox: {
      // y: 'bottom',
      feature: {
        magicType: {
          // type: ['stack', 'tiled', 'line', 'bar'],
          type: ['stack', 'tiled'],
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
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross'
      }
    },
    xAxis: {
      data: xAxisData,
      silent: false,
      splitLine: {
        show: false
      }
    },
    yAxis: [
      {
        type: 'value',
        name: 'Energy Prod.',
        ...calcAxisRange(_.flatten(barDataList) as number[]),
        axisLabel: { formatter: '{value} kWh' }
      },
      {
        type: 'value',
        name: 'Daylight',
        // ...calcAxisRange(_.flatten(lineDataList) as number[]),
        axisLabel: { formatter: '{value} h' }
      }
    ],
    series: [
      ...barDataList.map((data, i) => {
        return {
          name: `${cities[i]}`,
          type: 'bar',
          data: data.map(datum => {
            if (!datum) {
              return datum
            } else {
              return datum.toFixed(2)
            }
          }),
          animationDelay: (idx: number) => {
            return idx * 10 + 100 * i
          }
        }
      }),
      ...lineDataList.map((data, i) => {
        return {
          name: `${cities[i]}`,
          type: 'line',
          yAxisIndex: 1,
          data: data.map(datum => {
            if (!datum) {
              return datum
            } else {
              return datum.toFixed(2)
            }
          })
        }
      })
    ],
    animationEasing: 'elasticOut',
    animationDelayUpdate: (idx: number) => {
      return idx * 5
    }
  }
  return option
}

function calcAxisRange(dataArray: number[], scale = 10, stepNum = 5) {
  const [min, max] = [
    Math.ceil((_.min(dataArray) as number) / scale),
    Math.floor((_.max(dataArray) as number) / scale)
  ]
  const step = Math.ceil((max - min) / stepNum)
  return {
    min: (min - step / 2) * scale,
    max: (max + step / 2) * scale,
    interval: step * scale
  }
}
