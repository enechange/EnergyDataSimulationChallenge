// StatChartHelper.ts

/* eslint-disable comma-dangle */
import * as _ from 'lodash'
import * as echarts from 'echarts'
import * as ecStat from 'echarts-stat'

export interface totalWattTime {
  time: string,
  watt: number,
}

export interface totalWatt extends totalWattTime {
  date: Date,
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

export const totalWattClusterForHist = (dataList: totalWattTime[], clusterNumber: number) => {
  const data = dataList.map(totalWatt => {
    // const timeOffset = toISODateString(new Date(0))
    // const timeNum = Date.parse(`${timeOffset} ${totalWatt.time}`) as number
    return [0, totalWatt.watt]
  })
  return ecStat.clustering.hierarchicalKMeans(data, clusterNumber, false)
}

export const getThresholdsfromClusteringResult = (clusteringResult: ecStat.clustering.Result) => {
  const pointsInCluster = clusteringResult.pointsInCluster
  // BUG: ecStat.clustering.Result.pointsInCluster is number[][][] but .d.ts said it is number[][]
  const thresholds = _.sortBy(pointsInCluster.map(pointSet => {
    const resultSet = pointSet.map((point: any) => {
      const value = point as number[]
      return value[1]
    })
    return {
      min: _.min(resultSet) as number,
      max: _.max(resultSet) as number
    }
  }), ['min', 'max'])
  return thresholds
}

export const createTotalWattsCluster = (dataList: totalWattTime[], clusteringResult: ecStat.clustering.Result) => {
  const thresholds = getThresholdsfromClusteringResult(clusteringResult)
  const resultTotalWattsTimeSet: totalWattTime[][] = []
  dataList.forEach((totalWattTime, i) => {
    const { watt } = totalWattTime
    let clusterLabelIndex = 0
    thresholds.forEach((threshold, j) => {
      const { max, min } = threshold
      if (watt >= Math.floor(min) && watt <= Math.ceil(max)) {
        clusterLabelIndex = j
      }
    })
    if (resultTotalWattsTimeSet[clusterLabelIndex]) {
      resultTotalWattsTimeSet[clusterLabelIndex][i] = totalWattTime
    } else {
      resultTotalWattsTimeSet[clusterLabelIndex] = new Array(dataList.length)
      resultTotalWattsTimeSet[clusterLabelIndex][i] = totalWattTime
    }
  })
  return resultTotalWattsTimeSet
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
      // type: 'time',
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
          stack: true,
          data: totalWatts.map(totalWatt => {
            if (totalWatt) {
              return totalWatt.watt.toFixed(2)
            } else {
              return '-'
            }
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

export const formTotalWattTimeWithTimeOffset = (dataList: totalWattTime[]) => {
  const results: number[][] = []
  dataList.forEach((totalWattTime, i) => {
    const { time, watt } = totalWattTime
    const [hour, min, sec] = time.split(':')

    const timeNum = 3600 * parseInt(hour) + 60 * parseInt(min) + parseInt(sec)
    results[i] = [timeNum, watt]
  })
  return results
}

export const getClusterStep = (dataList: totalWattTime[], clusterNumber = 4) => {
  const data = formTotalWattTimeWithTimeOffset(dataList)
  const step = ecStat.clustering.hierarchicalKMeans(data, clusterNumber, true)
  return step
}

export const createPlotOption = () => {
  return {
    timeline: {
      top: 'center',
      right: 35,
      height: 300,
      width: 10,
      inverse: true,
      playInterval: 3000,
      symbol: 'none',
      orient: 'vertical',
      axisType: 'category',
      autoPlay: true,
      label: {
        normal: {
          show: false
        }
      },
      data: []
    },
    baseOption: {
      xAxis: {
        type: 'value',
        max: 3600 * 24,
        axisLabel: {
          formatter: (data: number) => {
            const timeZoneOffsetSec = (new Date()).getTimezoneOffset() * 60
            const dateOffset = new Date((data + timeZoneOffsetSec) * 1000)
            return `${dateOffset.getHours()}:${dateOffset.getMinutes()}`
          }
        }
      },
      yAxis: {
        type: 'value',
        name: 'Energy         \nConsumption',
        axisLabel: {
          formatter: (data: number) => {
            return `${data / 1000} kWh`
          }
        }
      },
      series: [{
        type: 'scatter'
      }]
    },
    options: []
  }
}

export function getOption(result: ecStat.clustering.Result, k: number) {
  const clusterAssment = result.clusterAssment
  const centroids = result.centroids
  const ptsInCluster = result.pointsInCluster
  const color = ['#c23531', '#2f4554', '#61a0a8', '#d48265', '#91c7ae', '#749f83', '#ca8622', '#bda29a', '#6e7074', '#546570', '#c4ccd3']
  const series = []
  for (let i = 0; i < k; i++) {
    series.push({
      name: 'Cluster' + i,
      type: 'scatter',
      animation: false,
      data: ptsInCluster[i],
      markPoint: {
        symbolSize: 29,
        label: {
          normal: {
            show: false
          },
          emphasis: {
            show: true,
            position: 'top',
            formatter: function (params: { data: { coord: number[]}}) {
              return Math.round(params.data.coord[0] * 100) / 100 + '  ' +
                Math.round(params.data.coord[1] * 100) / 100 + ' '
            },
            textStyle: {
              color: '#000'
            }
          }
        },
        itemStyle: {
          normal: {
            opacity: 0.7
          }
        },
        data: [{
          coord: centroids[i]
        }]
      }
    })
  }

  return {
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross'
      }
    },
    series: series,
    color: color
  }
}

const toISODateString = (date: Date) => date.toISOString().split('T')[0]
const toISOTimeString = (date: Date) =>
  date.toISOString().split('T')[1].replace('Z', '').split('.')[0]
