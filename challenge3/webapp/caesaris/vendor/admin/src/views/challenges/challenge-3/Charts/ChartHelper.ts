import * as echarts from 'echarts'
import * as _ from 'lodash'

export interface barData {
  [key: string]: {
    [label: string]: number[]
  },
}

export const createBarOption = (data: barData, labels: string[], cities: string[]) => {
  console.log(data, labels, cities)
  const xAxisData = labels
  const dataList: (number|null)[][] = []
  cities.forEach((city, i) => {
    dataList[i] = []
    for (const label of xAxisData) {
      if (data[city][label] && data[city][label][1]) {
        dataList[i].push(data[city][label][1])
      } else {
        dataList[i].push(null)
      }
    }
  })

  const option: echarts.EChartOption = {
    // title: {
    //   text: '柱状图动画延迟'
    // },
    legend: {
      data: cities,
      align: 'left'
    },
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
    tooltip: {},
    xAxis: {
      data: xAxisData,
      silent: false,
      splitLine: {
        show: false
      }
    },
    yAxis: {},
    series: dataList.map((data, i) => {
      return {
        name: cities[i],
        type: 'bar',
        data,
        animationDelay: (idx: number) => {
          return idx * 10 + 100 * i
        }
      }
    }),
    // series: [{
    //   name: 'bar',
    //   type: 'bar',
    //   data: data1,
    //   animationDelay: (idx: number) => {
    //     return idx * 10
    //   }
    // },
    // {
    //   name: 'bar2',
    //   type: 'bar',
    //   data: data2,
    //   animationDelay: (idx: number) => {
    //     return idx * 10 + 100
    //   }
    // }],
    animationEasing: 'elasticOut',
    animationDelayUpdate: (idx: number) => {
      return idx * 5
    }
  }
  return option
}
