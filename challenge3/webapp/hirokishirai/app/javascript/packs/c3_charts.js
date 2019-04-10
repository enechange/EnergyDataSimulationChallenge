import c3 from 'c3';

async function createHttpRequest(method, path, params={}) {
  const csrfToken = document.getElementsByTagName('meta')['csrf-token'].content
  let options = {}
  try {
    const headers = options.headers ? options.headers : new Headers()
    headers.append('Content-Type', 'application/json; charset=utf-8')
    headers.append('X-CSRF-TOKEN', csrfToken)
    options.headers = headers
    options.credentials = 'include'
    options.method = method

    const res = await fetch(
      path,
      options,
      JSON.stringify(params)
    )
    const body = await res.json()
    if (! res.ok && res.status !== 304) {
      throw e
    }
    return body
  } catch (e) {
      throw e
  }
}

async function getMonthlyHouseEnergyProductionsDataForTimeseries() {
  try {
    const resBody = await createHttpRequest('GET', window.location.pathname + '.json')
    return resBody
  } catch (e) {
      console.log(e.message)
  }
}

// TODO 好きな組み合わせでGETできるように
async function getMonthlyHouseEnergyProductionsDataForScatter() {
  try {
    const resBody = await createHttpRequest('GET', window.location.pathname + '/for_scatter.json')
    return resBody
  } catch (e) {
    console.log(e.message)
  }
}

document.addEventListener("turbolinks:load", async function(){
  if(document.getElementById("summary-timeseries-chart")) {
    const tChart = c3.generate({
      bindto: '#summary-timeseries-chart',
      data: {
        x: 'x',
        columns: []
      },
      axis: {
        x: {
          type: 'timeseries',
          tick: {
            format: '%Y-%m'
          }
        }
      }
    })
    tChart.load({
      columns: await getMonthlyHouseEnergyProductionsDataForTimeseries()
    })
  }

  // 散布図
  if(document.getElementById("temperature-energy_production-scatter-chart")) {
    var sChart = c3.generate({
      bindto: '#temperature-energy_production-scatter-chart',
      data: {
        xs: {
          '気温': 'エネルギー生産量'
        },
        columns: [],
        type: 'scatter'
      },
      axis: {
        x: {
          label: '気温',
          tick: {
              fit: false
          }
        },
        y: {
          label: 'エネルギー生産量'
        }
      }
    })
    sChart.load({
      columns: await getMonthlyHouseEnergyProductionsDataForScatter()
    })
  }
})
