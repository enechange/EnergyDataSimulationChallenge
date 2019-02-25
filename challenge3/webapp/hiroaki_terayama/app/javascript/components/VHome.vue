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
        charts: [],
        selectedData: [],
        allData: [],
        aveAll: 0,
        aveSelected: 0,
      }
    },
    watch: {
      charts (data) {
        this.setAry(this.convertToAry(data))
      },
      allData (data) {
        this.aveAll = this.ave_ary(data)
      },
      selectedData (data) {
        this.aveSelected = this.ave_ary(data)
      },
    },
    methods: {
      init () {
        this.fetchCharts( { q: { } } )
      },
      fetchCharts (params) {
        axios
            .get('/charts', { params: params , paramsSerializer } )
            .then(response => {
              this.charts = response.data
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
        let ary = []
        Object.keys(data).forEach(function (key) {
          ary.push(data[key])
        }.bind(this))
        return ary
      },
      showGraph () {
        this.isLoading = false
      },
      search (params) {
        this.fetchCharts(params)
      },
      ave_ary (ary) {
        if (ary.length > 0) {
          return Math.round(this.sum_ary(ary) / ary.length * 100) / 100
        }
      },
      sum_ary (ary) {
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