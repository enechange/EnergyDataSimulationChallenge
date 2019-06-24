// StatChartHelper.ts

/* eslint-disable comma-dangle */
import * as _ from 'lodash'
import * as echarts from 'echarts'
import clustering from 'echarts-stat'

export interface totalWatt {
  date: Date,
  time: string,
  watt: number,
}

export interface totalWattTime {
  time: string,
  watt: number,
}

export const fetchTotalWattCsv = async (url: string) => {
  const res = await fetch(url).then(res => res.text())
  const results = res.split(/\n|\r\n|\r/).map(res => {
    res = res.trim()
    if (res) {
      const [dateStr, watt] = res.split(',')
      const date = new Date(dateStr)
      return {
        date,
        time: toISOTimeString(date),
        watt: parseFloat(watt),
      } as totalWatt
    }
  }).filter(res => !_.isEmpty(res))
  return _.sortBy(results, ['date'])
}

export const aveTotalWattsByTime = (watts: totalWatt[]) => {
  const results: totalWattTime[] = []
  watts.forEach(wattItem => {
    const { time, watt } = wattItem
    const targetItem = _.find(results, o => o.time === time)
    if (targetItem) {
      targetItem.watt = (targetItem.watt + watt) / 2
    } else {
      results.push({ time, watt: watt })
    }
  })
  return _.sortBy(results, ['time'])
}

export const createHistOption = (dataList: totalWatt[][] | totalWattTime[][], dataSetLabel: string[]) => {
  let xAxisData: string[] = []
  if (dataList.length === 1) {
    xAxisData = (dataList[0] as totalWatt[]).map(item => {
      const { date, time } = item
      if (date) {
        return `${toISODateString(date)}\n${toISOTimeString(date)}`
      } else {
        return time
      }
    })
  } else {
    xAxisData = dataList.flat().map(item => item.time).sort()
  }

  const opt: echarts.EChartOption = {
    legend: {
      data: dataSetLabel,
      align: 'left'
    },
    dataZoom: [
      {
        show: true,
        type: 'inside',
      },
      {
        show: true,
        bottom: 0,
      },
      {
        show: true,
        yAxisIndex: 0,
        filterMode: 'empty',
        right: '6%',
      }
    ],
    toolbox: {},
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross'
      }
    },
    grid: {
      bottom: 80,
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
        name: 'Energy         \nConsumption',
        axisLabel: {
          formatter: (data: number) => {
            return `${data / 1000} kWh`
          }
        }
      },
    ],
    series: [
      ...(dataList as totalWatt[][]).map((totalWatts, i) => {
        return {
          name: `${dataSetLabel[i]}`,
          type: 'bar',
          data: totalWatts.map(totalWatt => {
            if (totalWatt.watt > 5000) {
              console.log(totalWatt)
            }
            return totalWatt.watt.toFixed(2)
          }),
          animationDelay: (idx: number) => {
            return idx * 0.5 + 10 * i
          }
        }
      })
    ],
    animationEasing: 'elasticOut',
    animationDelayUpdate: (idx: number) => {
      return idx * 0.5
    }
  }
  return opt
}

const toISODateString = (date: Date) => date.toISOString().split('T')[0]
const toISOTimeString = (date: Date) =>
  date.toISOString().split('T')[1].replace('Z', '').split('.')[0]
