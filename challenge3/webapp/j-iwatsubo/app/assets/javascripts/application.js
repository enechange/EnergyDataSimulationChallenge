//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/tabs
//= require dataTables/jquery.dataTables
//= require Chart.min

// data charge
$(function(){
    // show tabs
    $("#tabs").tabs();
    $("ul").css('height', $("li").height());

    // data table
    $("#house_data_table").dataTable();
    $("#energy_production_data_table").dataTable();

    // chart
    ctx_1 = document.getElementById("house_ave_chart").getContext('2d')
    myChart = new Chart(ctx_1, {
        type: 'bar',
        data: {
            labels: ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"],
            datasets: [{
                label: 'energy production',
                data: gon.house_ave_bardata,
                backgroundColor: [
                    'rgba(255, 100, 130, 0.3)',
                    'rgba(255, 120, 100, 0.3)',
                    'rgba(255, 120, 60, 0.3)',
                    'rgba(255, 188, 10, 0.3)',
                    'rgba(250, 240, 70, 0.3)',
                    'rgba(215, 230, 70, 0.3)',
                    'rgba(180, 230, 130, 0.3)',
                    'rgba(140, 220, 160, 0.3)',
                    'rgba(80, 200, 200, 0.3)',
                    'rgba(80, 220, 250, 0.3)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(255, 118, 104, 1)',
                    'rgba(255, 116, 60, 1)',
                    'rgba(255, 188, 10, 1)',
                    'rgba(250, 240, 70, 1)',
                    'rgba(215, 230, 70, 1)',
                    'rgba(180, 230, 130, 1)',
                    'rgba(140, 220, 160, 1)',
                    'rgba(80, 200, 200, 1)',
                    'rgba(80, 220, 250, 1)'
                ],
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
    });

    ctx_2 = document.getElementById("house_max_chart").getContext('2d')
    myChart = new Chart(ctx_2, {
        type: 'bar',
        data: {
            labels: ["1st", "2nd", "3rd", "4th", "5th", "6th", "7th", "8th", "9th", "10th"],
            datasets: [{
                label: 'energy production',
                data: gon.house_max_bardata,
                backgroundColor: [
                    'rgba(255, 100, 130, 0.3)',
                    'rgba(255, 120, 100, 0.3)',
                    'rgba(255, 120, 60, 0.3)',
                    'rgba(255, 188, 10, 0.3)',
                    'rgba(250, 240, 70, 0.3)',
                    'rgba(215, 230, 70, 0.3)',
                    'rgba(180, 230, 130, 0.3)',
                    'rgba(140, 220, 160, 0.3)',
                    'rgba(80, 200, 200, 0.3)',
                    'rgba(80, 220, 250, 0.3)'
                ],
                borderColor: [
                    'rgba(255, 99, 132, 1)',
                    'rgba(255, 118, 104, 1)',
                    'rgba(255, 116, 60, 1)',
                    'rgba(255, 188, 10, 1)',
                    'rgba(250, 240, 70, 1)',
                    'rgba(215, 230, 70, 1)',
                    'rgba(180, 230, 130, 1)',
                    'rgba(140, 220, 160, 1)',
                    'rgba(80, 200, 200, 1)',
                    'rgba(80, 220, 250, 1)'
                ],
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

});
