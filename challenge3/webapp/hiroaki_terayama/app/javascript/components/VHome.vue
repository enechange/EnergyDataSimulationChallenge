<template>
  <div>
    <v-header></v-header>
    <div class="section">
      <div class="container">
        <div class="columns is-parent">
          <div class="column is-6 is-child">
            <v-search-form @search="search"></v-search-form>
          </div>
          <div class="column is-6 is-child">
            <v-judge :aveAll="aveAll" :aveSelected="aveSelected"></v-judge>
          </div>
        </div>
        <v-table :allData="allData" :selectedData="selectedData"
                 :aveAll="aveAll" :aveSelected="aveSelected"></v-table>
        <line-chart v-if="!isLoading" :allData="allData" :selectedData="selectedData"></line-chart>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios'
  import qs from 'qs'
  import VHeader from './VHeader'
  import LineChart from './LineChart'
  import VSearchForm from '../components/VSearchFrom'
  import VTable from '../components/VTable'
  import VJudge from '../components/VJudge'
  const paramsSerializer = (params) => qs.stringify(params)

  export default {
    components: {
      VHeader, LineChart, VSearchForm, VTable, VJudge
    },
    data () {
      return {
        isLoading: true,
        chartData: [],
        selectedData: [],
        allData: [],
        aveAll: 0,
        aveSelected: 0,
      }
    },
    watch: {
      chartData (data) {
        this.setAry(this.convertToAry(data))
      },
      allData (data) {
        this.aveAll = this.aveAry(data.map(Number))
      },
      selectedData (data) {
        this.aveSelected = this.aveAry(data.map(Number))
      },
    },
    methods: {
      init () {
        this.fetchChartData( { q: { } } )
      },
      fetchChartData (params) {
        axios
            .get('/charts', { params: params , paramsSerializer } )
            .then(response => {
              this.chartData = response.data
              if (this.isLoading === true) this.showGraph()
            }).catch(errors => {
          console.log(errors)
        })
      },
      setAry (ary) {
        if (this.allData.length < 1) {
          this.allData = ary
        } else {
          this.selectedData = ary
        }
      },
      convertToAry (data) {
        return Object.keys(data).map(function (key) { return data[key] })
      },
      showGraph () {
        this.isLoading = false
      },
      search (params) {
        this.fetchChartData(params)
      },
      aveAry (ary) {
        if (ary.length > 0) {
          return Math.round(this.sumAry(ary) / ary.length * 100) / 100
        }
      },
      sumAry (ary) {
        return ary.reduce(function(prev, current, i, ary) {
          return prev + current
        })
      },
    },
    created () {
      this.init()
    },
  }
</script>