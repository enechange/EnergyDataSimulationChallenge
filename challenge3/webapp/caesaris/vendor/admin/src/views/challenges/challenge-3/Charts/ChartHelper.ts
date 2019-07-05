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
        fontSize: 14,
      },
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
        right: '1%',
      },
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
            bar: 'Bar',
          },
        },
        dataView: {
          show: false,
          // title: 'Data View',
          // lang: ['Chart', 'Close', 'Refresh']
        },
        saveAsImage: {
          title: 'Save',
          pixelRatio: 2,
        },
      },
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: {
        type: 'cross',
      },
      formatter: (data) => {
        return formatBarTooltip(data as tooltipData[])
      },
    },
    xAxis: {
      data: xAxisData,
      silent: false,
      splitLine: {
        show: false,
      },
    },
    yAxis: [
      {
        type: 'value',
        name: 'Energy Prod.',
        min: calcAxisRange(_.flatten(barDataList) as number[]).min,
        axisLabel: { formatter: '{value} kWh' },
      },
      {
        type: 'value',
        name: 'Daylight',
        // ...calcAxisRange(_.flatten(lineDataList) as number[]),
        axisLabel: { formatter: '{value} h' },
      },
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
          },
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
          }),
        }
      }),
    ],
    animationEasing: 'elasticOut',
    animationDelayUpdate: (idx: number) => {
      return idx * 5
    },
  }
  return option
}

export const createScatterOption = (dataList: (number | string)[][][], labels: string[], daylightRange: number[]) => {
  const schema = [
    { name: 'daylight', index: 0, text: 'Daylight', unit: 'h' },
    { name: 'temperature', index: 0, text: 'Temp.', unit: '℃' },
    { name: 'energyProduction', index: 0, text: 'Nrg. Prod.', unit: 'kWh' },
    { name: 'fullName', index: 0, text: 'Name' },
    { name: 'dateStr', index: 0, text: 'Date' },
  ]
  const option: echarts.EChartOption = {
    legend: {
      y: 'top',
      data: labels,
      textStyle: {
        fontSize: 14,
      },
    },
    // dataZoom: [
    //   {
    //     show: true,
    //     type: 'inside',
    //     orient: 'vertical',
    //   },
    // ],
    xAxis: {
      type: 'value',
      name: 'Daylight',
      ...calcAxisRange(daylightRange),
      axisLabel: { formatter: '{value} h' },
    },
    yAxis: {
      type: 'value',
      name: 'Temp.',
      axisLabel: { formatter: '{value} ℃' },
    },
    toolbox: {
      top: 0,
      feature: {
        dataView: {
          show: false,
        },
        saveAsImage: {
          title: 'Save',
          pixelRatio: 2,
        },
      },
    },
    tooltip: {
      // trigger: 'axis',
      axisPointer: {
        type: 'cross',
      },
      formatter: (data) => {
        // console.log(data)
        return formatScatterTooltip([data] as tooltipData[], schema)
      },
    },
    visualMap: [{
      left: 'right',
      top: '7.5%',
      dimension: 2,
      min: 200,
      max: 1100,
      precision: 0,
      text: ['Size: Nrg. Prod.(kWh)'],
      textGap: 20,
      textStyle: {
        fontSize: 11,
        width: 5,
      },
      padding: 0,
      inRange: {},
      outOfRange: {
        symbolSize: [10, 70],
      },
      controller: {
        inRange: {
          color: ['rgba(194, 53, 49, .6)'],
        },
        outOfRange: {
          color: ['rgba(0, 0, 0, .0)'],
        },
      },
    }],
    series: labels.map((city, i) => {
      return {
        name: city,
        type: 'scatter',
        symbolSize: (val: (number | string)[], param: {}) => {
          const energyProd = val[2] as number // 1088 ~ 254
          // const size = 1.9 * (energyProd / 250) ** 2
          // Use exponential func. to amplify delta
          const size = 0.85 * Math.exp(energyProd / 250)
          return size
        },
        itemStyle: {
          normal: {
            opacity: 0.2,
            shadowBlur: 1,
            shadowOffsetX: 0,
            shadowOffsetY: 0,
            shadowColor: 'rgba(0, 0, 0, 0.15)',
          },
        },
        data: dataList[i],
      }
    }),
  }
  return option
}

export interface scatterGraphqlData {
  cities: [{
    name: string,
    houses: [{
      id: string | number,
      fullName: string,
    }]
    datasets: [{
      dateStr: string,
      temperature: number,
      daylight: number,
      energyProduction: number,
      houseId: number,
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
      const house = findHouseById(ds.houseId, c.houses)
      const fullName = house ? house.fullName : ''
      return [
        ds.daylight,
        ds.temperature,
        ds.energyProduction,
        fullName,
        ds.dateStr,
      ]
    })
    dataList[i] = dataColumn
  })

  return { labels, dataList, daylightRange: [daylightMin, daylightMax] }
}

interface tooltipData {
  color: string,
  data: (number | string)[],
  marker: string,
  name: string,
  seriesName: string,
  seriesType: string,
}

interface dataSchema {
  name: string,
  index: number,
  text: string,
  unit?: string,
}

function formatBarTooltip(dataList: tooltipData[]) {
  const ttlStyle = 'display: block;font-size: 15px;font-weight: bold;text-align: center;'
  const subTtlStyle = 'display: inline-block;font-size: 13px;font-weight: bold;padding-left: 5px;'
  const listStyle = 'display: inline-block;font-size: 12px;font-weight: normal;padding-left: 10px;'
  let date = ''
  let barDataHtml = `<div><span style="${subTtlStyle}">Average Energy Prod.</span><br>`
  barDataHtml += dataList.filter(dataSet => dataSet.seriesType.toLowerCase() === 'bar').map(dataSet => {
    date = dataSet.name
    const city = dataSet.seriesName
    const energyProd = dataSet.data.toString()
    return `
      <span style="${listStyle}">${dataSet.marker}${city}: ${energyProd} kWh</span>
    `
  }).join('<br>')
  barDataHtml += '</div>'

  let lineDataHtml = `<div><span style="${subTtlStyle}">Average Daylight</span><br>`
  lineDataHtml += dataList.filter(dataSet => dataSet.seriesType.toLowerCase() === 'line').map(dataSet => {
    const city = dataSet.seriesName
    const daylight = dataSet.data.toString()
    return `
      <span style="${listStyle}">${dataSet.marker}${city}: ${daylight} h</span>
    `
  }).join('<br>')
  lineDataHtml += '</div>'

  const outerHtml = `
    <div>
      <span style="${ttlStyle}">Date: ${date}</span><hr>
      ${[barDataHtml, lineDataHtml].join('')}
    </div>
  `
  return outerHtml
}

function formatScatterTooltip(dataList: tooltipData[], schema: dataSchema[]) {
  const ttlStyle = 'display: block;font-size: 14px;font-weight: bold;'
  const listStyle = 'display: block;font-size: 12px;font-weight: normal;padding-left: 15px;'
  const outerHtml = dataList.map(dataSet => {
    const name = dataSet.data[3]
    const date = dataSet.data[4]
    const city = dataSet.seriesName
    let html = `
    <div>
      <span style="${ttlStyle}">
        ${dataSet.marker}${name} [ ${city} ]
      </span>
      <span style="${listStyle}">Date: ${date}</span>
      ${[0, 1, 2].map(i => `
        <span style="${listStyle}">
          ${schema[i].text}: ${dataSet.data[i]} ${schema[i].unit || ''}
        </span>`).join('')}
    </div>
    `
    return html
  }).join('<hr>')
  return outerHtml
}

interface house {
  id: string | number,
  fullName: string,
}

function findHouseById(id: number, houses: [house]) {
  return _.find(houses, _.matchesProperty('id', id.toString()))
}

function calcAxisRange(dataArray: number[], scale = 10, stepNum = 5) {
  const [min, max] = [
    Math.ceil((_.min(dataArray) as number) / scale),
    Math.floor((_.max(dataArray) as number) / scale),
  ]
  const step = Math.ceil((max - min) / stepNum)
  return {
    min: (min - step / 2) * scale,
    max: (max + step / 2) * scale,
    interval: step * scale,
  }
}
