<template lang="pug">
  div(style='padding:30px;')
    h1.challenge-ttl Challenge 2
    p.challenge-txt Visualization of Energy Consumptions
    el-tabs(v-model='activeName', @tab-click='handleClick')
      el-tab-pane.tab-panel(label='Histogram', name='histogram', lazy=true)
        histogram(v-if='dataLoadedFlg', :data-list='[totalWatts]', title='Energy Consumption Per 30mins')
      el-tab-pane.tab-panel(label='Cluster Plot', name='cluster-plot', lazy=true)
        // cluster-plot
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { fetchTotalWattCsv, aveTotalWattsByTime, totalWatt } from './Charts/StatChartHelper'
import Histogram from './Charts/Histogram.vue'

// TODO: load from `api/app_config`
const totalWattUrl = 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge2/data/total_watt.csv'

@Component({
  components: { Histogram }
})
export default class Challenge2 extends Vue {
  private activeName: string = 'histogram'
  private totalWatts: totalWatt[] = []
  private dataLoadedFlg: boolean = false

  mounted() {
    fetchTotalWattCsv(totalWattUrl).then(async totalWatts => {
      console.log(totalWatts)
      if (totalWatts) {
        this.totalWatts = totalWatts as totalWatt[]
        console.log(aveTotalWattsByTime(this.totalWatts))
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
