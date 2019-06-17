<template lang="pug">
  el-tabs(v-model='activeName', @tab-click='handleClick')
    el-tab-pane(label='Scatter Plot', name='scatter-plot') Scatter Plot
    el-tab-pane(label='Polar Area', name='polar-area') Polar Area
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'

@Component
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
