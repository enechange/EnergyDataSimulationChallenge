window.draw_graph = ->
    ctx1 = document.getElementById("g1").getContext('2d')
    labels_g1 = gon.year_month_g1
    data_g1 = gon.energy_production_g1
    graph1 = new Chart(ctx1, {
        type: 'line',
        data: {
            labels: labels_g1,
            datasets: [
                {
                    label: 'Cambridge',
                    data: data_g1['Cambridge'],
                    backgroundColor: 'rgba(102, 51, 0, 1)',
                    borderColor: 'rgba(153, 51, 0, 1)',
                    fill: false
                },
                {
                    label: 'London',
                    data: data_g1['London'],
                    backgroundColor: 'rgba(204, 0, 0, 1)',
                    borderColor: 'rgba(255, 0, 0, 1)',
                    fill: false
                },
                {
                    label: 'Oxford',
                    data: data_g1['Oxford'],
                    backgroundColor: 'rgba(0, 153, 153, 1)',
                    borderColor: 'rgba(51, 153, 153, 1)',
                    fill: false
                }
            ]
        },
        options: {
            title:  {
                display: true,
                text: '都市毎の平均エネルギー生産量',
                fontSize: 14,
            },
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    })

    ctx2 = document.getElementById("g2").getContext('2d')
    data_g2 = gon.data_g2
    graph2 = new Chart(ctx2, {
        type: 'scatter',
        data: {
            datasets: [
                {
                    label: 'daylight, energy production',
                    data: data_g2,
                    backgroundColor: 'rgba(0, 102, 0, 1)',
                }
            ]
        },
        options: {
            title:  {
                display: true,
                text: '日射量とエネルギー生産量の分布',
                fontSize: 14,
            },
            scales: {
                xAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: '日射量'
                    }
                }],
                yAxes: [{
                    scaleLabel: {
                        display: true,
                        labelString: 'エネルギー生産量'
                    }
                }]
            }
        }
    })
