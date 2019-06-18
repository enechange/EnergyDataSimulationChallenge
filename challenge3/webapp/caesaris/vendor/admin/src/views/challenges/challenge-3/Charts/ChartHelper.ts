/* eslint-disable comma-dangle */
/* eslint-disable */
import * as echarts from 'echarts'
import * as _ from 'lodash'

export interface barData {
  [key: string]: {
    [label: string]: number[]
  },
}

export const createBarOption = (barData: barData, lineData: barData, labels: string[], cities: string[]) => {
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
      align: 'left',
      textStyle: {
        fontSize: 14
      }
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
          show: false,
          // title: 'Data View',
          // lang: ['Chart', 'Close', 'Refresh']
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
        min: calcAxisRange(_.flatten(barDataList) as number[]).min,
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

export const createScatterOption = () => {
  const option: echarts.EChartOption = {
    legend: {
      y: 'top',
      data: ['data', 'data2'],
      textStyle: {
        fontSize: 14
      }
    },
    xAxis: {},
    yAxis: {},
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross'
      },
      // formatter: '{a0}: {c0}',
    },
    series: [{
      name: 'data',
      symbolSize: 20,
      data: [
        [10.0, 8.04],
        [8.0, 6.95],
        [13.0, 7.58],
        [9.0, 8.81],
        [11.0, 8.33],
        [14.0, 9.96],
        [6.0, 7.24],
        [4.0, 4.26],
        [12.0, 10.84],
        [7.0, 4.82],
        [5.0, 5.68]
      ],
      type: 'scatter',
    },
    {
      // symbolSize: 20,
      name: 'data2',
      data: [
        [10.0, 8.04],
        [8.0, 6.95],
        [13.0, 7.58],
        [9.0, 8.81],
        [11.0, 8.33],
        [14.0, 9.96],
        [6.0, 7.24],
        [4.0, 4.26],
        [12.0, 10.84],
        [7.0, 4.82],
        [5.0, 5.68]
      ].map(arr => _.reverse(arr)),
      type: 'scatter'
    }]
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
