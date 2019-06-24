<template lang="pug">
  div(style='padding:30px;')
    h1.challenge-ttl Challenge 2
    p.challenge-txt Visualization of Energy Consumptions
    el-tabs(v-model='activeName', @tab-click='handleClick')
      el-tab-pane.tab-panel(label='Per 30mins', name='histogram-per-30mins', lazy=true)
        histogram(v-if='dataLoadedFlg', :data-list='[totalWatts]',
          id='histogram-per-30mins', title='Energy Consumption Per 30mins')
      el-tab-pane.tab-panel(label='Per Day', name='histogram-per-day', lazy=true)
        histogram(v-if='dataLoadedFlg', :data-list='totalWattsClusted',
          :data-set-label='histogramClusterLabels',
          id='histogram-per-day', title='Energy Consumption Per Day')
      el-tab-pane.tab-panel(label='Cluster Plot', name='cluster-plot', lazy=true)
        // cluster-plot
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import {
  fetchTotalWattCsv,
  aveTotalWattsByTime,
  totalWattClusterForHist,
  createTotalWattsCluster,
  totalWatt,
  totalWattTime
} from './Charts/StatChartHelper'
import Histogram from './Charts/Histogram.vue'

// TODO: load from `api/app_config`
const totalWattUrl = 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge2/data/total_watt.csv'

@Component({
  components: { Histogram }
})
export default class Challenge2 extends Vue {
  private activeName: string = 'histogram-per-30mins'
  private totalWatts: totalWatt[] = []
  private totalWattsClusted: totalWattTime[][] = []
  private histogramClusterLabels: string[] = ['Low', 'Mid', 'High']
  private dataLoadedFlg: boolean = false

  mounted() {
    fetchTotalWattCsv(totalWattUrl).then(async totalWatts => {
      if (totalWatts) {
        this.totalWatts = totalWatts as totalWatt[]
        const totalWattsTime = aveTotalWattsByTime(this.totalWatts)
        console.log(totalWattsTime)
        const clusterRes = totalWattClusterForHist(totalWattsTime, 3)
        this.totalWattsClusted = createTotalWattsCluster(totalWattsTime, clusterRes)
        console.log(this.totalWattsClusted)

        // console.log(totalWattClusterForHist(totalWattsTime, 3))

        this.dataLoadedFlg = true
      }
    })
  }

  handleClick(tab: C, event: MouseEvent) {
    // console.log(tab.name, event)
  }
}
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";
</style>
