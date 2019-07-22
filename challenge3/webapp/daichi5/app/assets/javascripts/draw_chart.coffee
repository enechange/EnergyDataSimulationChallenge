window.draw_chart = -> 
    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: gon.dataset["labels"],
            datasets: [{
                label: 'Average Temperature',
                data: gon.dataset["temperature"],
                backgroundColor: ['rgba(255, 99, 132, 0.2)'],
                borderColor: ['rgba(255,99,132,1)'],
                borderWidth: 1
            }, {
                label: 'Average Daylight'
                data: gon.dataset["daylight"]
                backgroundColor: [ 'rgba(54, 162, 235, 0.2)' ]
                borderColor: [ 'rgba(54, 162, 235, 1)' ]
                borderWidth: 1
            }, {
                label: 'Average EnergyProduction'
                data: gon.dataset["production"]
                backgroundColor: [ 'rgba(255, 206, 86, 0.2)' ]
                borderColor: [ 'rgba(255, 206, 86, 1)' ]
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    })
