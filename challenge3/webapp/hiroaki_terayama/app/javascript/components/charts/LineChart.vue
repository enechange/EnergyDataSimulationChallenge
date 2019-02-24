<script>
  import { Line, mixins } from 'vue-chartjs'

  export default {
    mixins: [Line, mixins.reactiveData],
    name: 'LineChart',
    props: ['defaultData', 'dataAry'],
    data () {
      return {
        chartData: {
          labels: [ "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月" ] ,
          datasets: [
            {
              label: 'energy_production / month(yours)',
              backgroundColor: 'red',
              pointBackgroundColor: 'white',
              borderWidth: 1,
              pointBorderColor: '#249EBF',
              data: [],
            },
            {
              label: 'energy_production / month(all)',
              backgroundColor: 'grey',
              pointBackgroundColor: 'white',
              borderWidth: 1,
              pointBorderColor: '#249EBF',
              data: [],
            },
          ],
        },
        options: {
          scales: {
            yAxes: [{
              ticks: {
                beginAtZero: true
              },
              gridLines: {
                display: true
              }
            }],
            xAxes: [{
              gridLines: {
                display: true
              }
            }]
          },
          legend: {
            display: true
          },
          responsive: true,
          maintainAspectRatio: false
        }
      }
    },
    watch: {
      dataAry () {
        this.updateChart()
      }
    },
    methods: {
      updateChart () {
        const newChartData = Object.assign({}, this.chartData)
        newChartData.datasets[0].data = this.dataAry
        this.chartData = newChartData
      },
      setDefault () {
        const newChartData = Object.assign({}, this.chartData)
        newChartData.datasets[1].data  = this.defaultData
        this.chartData = newChartData
      }
    },
    mounted () {
      this.setDefault()
      this.renderChart(this.chartData, this.options)
    }
  }
</script>
