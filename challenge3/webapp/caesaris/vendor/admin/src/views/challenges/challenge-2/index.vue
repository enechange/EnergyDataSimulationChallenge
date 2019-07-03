<template lang="pug">
  div(style='padding:30px;')
    h1.challenge-ttl Challenge 2
    p.challenge-txt Visualization of Energy Consumptions
    el-tabs(v-model='activeName', @tab-click='handleClick')
      el-tab-pane.tab-panel(label='Per 30mins', name='histogram-per-30mins', lazy=true)
        histogram(:data-list='[totalWatts]', id='histogram-per-30mins',
          title='Energy Consumption Per 30mins')
      el-tab-pane.tab-panel(label='Per Day', name='histogram-per-day', lazy=true)
        histogram(:data-list='totalWattsClusted',
          :data-set-label='histogramClusterLabels', id='histogram-per-day',
          title='Average Energy Consumption Per Day', sub-ttl='Clustered By KMeans')
      el-tab-pane.tab-panel(label='Cluster Plot', name='cluster-plot', lazy=true)
        cluster-plot(:data-list='totalWatts')
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { MessageBox } from 'element-ui'
import { UserModule } from '@/store/modules/user'
import {
  fetchTotalWattCsv,
  aveTotalWattsByTime,
  totalWattClusterForHist,
  createTotalWattsCluster,
  getThresholdsfromClusteringResult,
  totalWatt,
  totalWattTime,
} from './Charts/StatChartHelper'
import Histogram from './Charts/Histogram.vue'
import ClusterPlot from './Charts/ClusterPlot.vue'

@Component({
  components: { Histogram, ClusterPlot },
})
export default class Challenge2 extends Vue {
  private activeName: string = 'histogram-per-30mins'
  private totalWatts: totalWatt[] = []
  private totalWattsTime: totalWattTime[] = []
  private totalWattsClusted: totalWattTime[][] = []
  private histogramClusterLabels: string[] = ['Low', 'Mid', 'High']
  private dataLoadedFlg: boolean = false

  mounted() {
    const { totalWattUrl } = UserModule.appConfigs.challenge2
    fetchTotalWattCsv(totalWattUrl).then(async totalWatts => {
      if (totalWatts) {
        this.totalWatts = totalWatts as totalWatt[]
        const totalWattsTime = aveTotalWattsByTime(this.totalWatts)
        this.totalWattsTime = totalWattsTime
        const clusterRes = totalWattClusterForHist(totalWattsTime, 3)
        const thresholds = getThresholdsfromClusteringResult(clusterRes)
        thresholds.forEach((threshold, i) => {
          const { min, max } = threshold
          this.histogramClusterLabels[i] =
            `${this.histogramClusterLabels[i]} (${Math.floor(min)} ~ ${Math.ceil(max)})`
        })
        this.totalWattsClusted = createTotalWattsCluster(totalWattsTime, clusterRes)
        this.dataLoadedFlg = true
      }
    }).catch(error => {
      console.error(error)
      MessageBox.alert('Challenge 2 CSV URL Errored', {
        confirmButtonText: 'Setup URL',
      }).then(() => {
        this.$router.push({ path: '/console/index' })
      }).catch(() => { /* Handle `cancel` Action */ })
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
