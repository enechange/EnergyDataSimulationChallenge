// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
google.charts.load('current', {'packages': ['corechart']});
google.charts.setOnLoadCallback(() => {
    var monthlyData = new google.visualization.DataTable();

    Object.entries(gon.monthly_energies.data_attr_keys).forEach(([key, type]) => monthlyData.addColumn(type, key));
    monthlyData.addRows(gon.monthly_energies.data_rows);

    new google.visualization.LineChart(
        document.getElementById('first_chart')
    ).draw(
        monthlyData,
        {
            title: '都市ごとのエネルギー生産量',
            width: 900,
            height: 500,
        },
    );

    var parsonalyData = new google.visualization.DataTable;

    Object.entries(gon.parsonaly_energies.data_attr_keys).forEach(([key, type]) => parsonalyData.addColumn(type, key));
    parsonalyData.addRows(gon.parsonaly_energies.data_rows);

    new google.visualization.BarChart(
        document.getElementById('second_chart')
    ).draw(
        parsonalyData,
        {
            title: '世帯人数ごとの1人あたりのエネルギー生産量平均',
            width: 900,
            height: 500,
        },
    );
});
