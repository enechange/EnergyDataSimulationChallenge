<template lang="pug">
  .chart
    p Polar Area
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'

@Component
export default class PolarArea extends Vue {
  beforeCreate() {
    console.log('PolarArea', 'beforeCreate')
  }

  beforeMount() {
    console.log('PolarArea', 'beforeMount')
  }

  beforeUpdate() {
    console.log('PolarArea', 'beforeUpdate')
  }
}
</script>
