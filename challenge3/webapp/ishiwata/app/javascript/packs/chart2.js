import Vue from 'vue/dist/vue.esm.js'
import Line from './components/chart/LineChart.vue'
import axios from 'axios';

var app2 = new Vue({
  el: '#app2',
  components: {
    'line-chart' : Line
  },
  data: {
    labels: [],
    data: [],
    datacollection: null,
    options: {
    responsive: true,    //グラフサイズの自動調整
    legend: {
        display: false   //凡例の非表示
   },
    title: {
        display: true,   //タイトルの表示
        fontSize: 18,    //フォントサイズ
        text: '気温の推移'   //グラフ名表示
    },
    scales: {
        yAxes: [{
            display: true,        //Y軸の表示
            scaleLabel: {
               display: true,     //Y軸のラベル表示
               labelString: '気温',  //Y軸のラベル
               fontSize: 18       //Y軸のラベルのフォントサイズ
            },
            ticks: {
                min: 0,           //Y軸の最小値
                max: 35,          //Y軸の最大値
                fontSize: 18,     //Y軸のフォントサイズ
                stepSize: 5       //Y軸の間隔
            },
        }],
        xAxes: [{
            display: true,        //X軸の表示
            scaleLabel: {
               display: true,     //X軸の表示
               labelString: '一ヶ月ごと',  //X軸のラベル
               fontSize: 18       //X軸のラベルのフォントサイズ
            },
            ticks: {
                fontSize: 18      //X軸のフォントサイズ
            },
        }],
    },
    }
  },
  methods:{
    fillData () {
        this.datacollection = {
          labels: this.labels,
          datasets:[
            {
              type: 'line',
              lineTension: 0,
              fill: false,
              label: 'グラフ2',
              backgroundColor: '#f87979',
              borderColor: '#f87979',
              data: this.data
            }]
        }
    }
  },
  mounted :function(){
    axios.get(location.href+".json")
    .then(response => {
      this.data = response.data.map(energy => Number(energy.temperature));
      this.labels = response.data.map(energy => energy.year+"-"+energy.month);

      this.fillData();
    })
  }
});
