<template>
  <div>
    <v-search-form @search="search"></v-search-form>
    <line-chart v-if="!isLoading" :defaultData="defaultData" :dataAry="dataAry"></line-chart>
  </div>
</template>

<script>
  import axios from 'axios'
  import qs from 'qs'
  import LineChart from './charts/LineChart'
  import VSearchForm from '../components/VSearchFrom'
  const paramsSerializer = (params) => qs.stringify(params)

  export default {
    components: {
      LineChart, VSearchForm
    },
    data () {
      return {
        isLoading: true,
        charts: [],
        dataAry: [],
        defaultData: [],
      }
    },
    watch: {
      charts (data) {
        this.setAry(this.convertToAry(data))
      },
      dataAry () {
        if (this.dataAry.length < 1) alert('Sorry, there is not enough data.')
      }
    },
    methods: {
      init () {
        this.fetchCharts({ q: { } } )
      },
      fetchCharts (params) {
        axios
            .get('/charts', { params: params , paramsSerializer })
            .then(response => {
              this.charts = response.data
              if (this.isLoading === true) this.showGraph()
            }).catch(errors => {
          console.log(errors)
        })
      },
      setAry (ary) {
        if (this.defaultData.length < 1) {
          this.defaultData = ary
        } else {
          this.dataAry = ary
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
    },
    created () {
      this.init()
    },
  }
</script>