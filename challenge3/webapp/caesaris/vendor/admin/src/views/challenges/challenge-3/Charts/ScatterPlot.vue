<template lang="pug">
  .chart
    p Scatter Plot
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'

@Component
export default class ScatterPlot extends Vue {
  beforeCreate() {
    console.log('ScatterPlot', 'beforeCreate')
  }

  beforeMount() {
    console.log('ScatterPlot', 'beforeMount')
  }

  beforeUpdate() {
    console.log('ScatterPlot', 'beforeUpdate')
  }
}
</script>
