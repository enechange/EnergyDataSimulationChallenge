<template lang="pug">
  el-tabs(v-model='activeName', @tab-click='handleClick')
    el-tab-pane.tab-panel(label='Bar Chart', name='bar-chart', lazy=true)
      bar-chart
    el-tab-pane.tab-panel(label='Scatter Plot', name='scatter-plot', lazy=true)
      scatter-plot
    el-tab-pane.tab-panel(label='Polar Area', name='polar-area', lazy=true)
      polar-area
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import BarChart from './Charts/BarChart.vue'
import ScatterPlot from './Charts/ScatterPlot.vue'
import PolarArea from './Charts/PolarArea.vue'

@Component({
  components: { BarChart, ScatterPlot, PolarArea }
})
export default class TabArea extends Vue {
  activeName: string = 'bar-chart'

  beforeCreate() {
    console.log(this.$route)
  }

  handleClick(tab: C, event: MouseEvent) {
    console.log(tab.name, event)
  }
}
</script>

<style lang="scss" scoped>
.tab-panel {
  padding-top: 10px;
  padding-bottom: 10px;
}
</style>
