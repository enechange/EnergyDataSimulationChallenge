<template lang="pug">
  el-tabs(v-model='activeName', @tab-click='handleClick')
    el-tab-pane.tab-panel(label='Scatter Plot', name='scatter-plot', lazy=true)
      scatter-plot
    el-tab-pane.tab-panel(label='Polar Area', name='polar-area', lazy=true)
      polar-area
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import ScatterPlot from './Charts/ScatterPlot.vue'
import PolarArea from './Charts/PolarArea.vue'

@Component({
  components: { ScatterPlot, PolarArea }
})
export default class TabArea extends Vue {
  activeName: string = 'scatter-plot'

  beforeCreate() {
    console.log(this.$route)
    fetch('http://localhost:18000/api/city_list')
      .then(res => res.json())
      .then(json => {
        console.log(json)
      })
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
