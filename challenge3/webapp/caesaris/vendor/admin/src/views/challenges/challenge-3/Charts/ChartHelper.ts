/* eslint-disable comma-dangle */
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

export const createScatterOption = (dataList: (number | string)[][][], labels: string[], daylightRange: number[]) => {
  const option: echarts.EChartOption = {
    legend: {
      y: 'top',
      data: labels,
      textStyle: {
        fontSize: 14
      }
    },
    xAxis: {
      type: 'value',
      name: 'Daylight',
      ...calcAxisRange(daylightRange),
      axisLabel: { formatter: '{value} h' }
    },
    yAxis: {
      type: 'value',
      name: 'Temp.',
      axisLabel: { formatter: '{value} ℃' }
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross'
      },
      // formatter: '{a0}: {c0}',
    },
    series: labels.map((city, i) => {
      return {
        name: city,
        type: 'scatter',
        // symbolSize: 20,
        data: dataList[i]
      }
    })
  }
  return option
}

export interface scatterGraphqlData {
  cities: [{
    name: string,
    datasets: [{
      dateStr: string,
      temperature: number,
      daylight: number,
      house: { fullName: string }
    }]
  }]
}

export const formatScatterGraphqlData = (rawData: scatterGraphqlData) => {
  const cities = rawData.cities
  const labels: string[] = []
  const dataList: (number | string)[][][] = []
  let daylightMax: number = 0
  let daylightMin: number = Number.MAX_VALUE

  cities.forEach((c, i) => {
    labels[i] = c.name
    const dataColumn = c.datasets.map(ds => {
      if (daylightMax < ds.daylight) {
        daylightMax = ds.daylight
      }
      if (daylightMin > ds.daylight) {
        daylightMin = ds.daylight
      }
      return [
        ds.daylight,
        ds.temperature,
        ds.house.fullName,
        ds.dateStr
      ]
    })
    dataList[i] = dataColumn
  })

  return { labels, dataList, daylightRange: [daylightMin, daylightMax] }
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
