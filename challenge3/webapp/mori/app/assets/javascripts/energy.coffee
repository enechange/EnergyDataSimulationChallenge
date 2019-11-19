window.draw_graph = -> 

    ctx = document.getElementById("myChart").getContext('2d')
    myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            datasets: [
                {
                    label: 'London',
                    data: gon.dataLondon,
                    borderColor: 'rgba(255, 99, 132, 1.0)',
                    backgroundColor: 'rgba(255,99,132,1)'
                },
                {
                    label: 'Oxford',
                    data: gon.dataOxford,
                    borderColor: 'rgba(54, 162, 235, 0.2)',
                    backgroundColor: 'rgba(54, 162, 235, 1)'
                },
                {
                    label: 'Cambridge',
                    data: gon.dataCambridge,
                    borderColor: 'rgba(255, 206, 86, 0.2)',
                    backgroundColor: 'rgba(255, 206, 86, 1)'
                }
            ],
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }],
                xAxes: [{
                    barPercentage: 0.5,
                    
                }]
            }
        }
    });

    ctx1 = document.getElementById("Chartdemo").getContext('2d')
    myChart = new Chart(ctx1, {
        type: 'line',
        data: {
            datasets: [
                {
                    label: 'London',
                    data: gon.data2011,
                    backgroundColor: 'rgba(255,99,132,1)'
                },
                {
                    label: 'Oxford',
                    data: gon.data2011,
                    backgroundColor: 'rgba(54, 162, 235, 1)'
                }
            ],
        }
    });
    
    