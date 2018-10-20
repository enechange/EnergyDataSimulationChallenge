// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
window.dashbords = Object.create({});
window.dashbords.dataHandler = function(svname) {
    //  自身のクラスをselfとして保持
    var _self = this;

    //  プライベートメソッド
    var formatName = function(number){
        return _self.service_name + "へようこそ(" + _country + ")" + number;
    };

    //  パブリックメソッド
    _self.render_graph_data1 = function(element_id){
        var ctx = $(element_id)[0].getContext('2d');
        $.ajax({url: "data.json", success: function(result){
            var myChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: Object.keys(result["city_sum"]),
                    datasets: [{
                        label: 'Sum of number of people in each city',
                        data: Object.values(result["city_sum"]),
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
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
        }});
    };

    _self.render_graph_data2 = function(element_id){
        var ctx = $(element_id)[0].getContext('2d');
        $.ajax({url: "data.json", success: function(result){
            var myChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: Object.keys(result["temperature_avg"]),
                    datasets: [
                        {
                            label: 'Average of tempreture of each year',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            data: Object.values(result["temperature_avg"]),
                        },
                    ]
                },
                options: {
                    responsive: true,
                }
            });
        }});
    };
    return _self;
};

