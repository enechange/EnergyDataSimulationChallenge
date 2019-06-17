<template lang="pug">
  .chart
    p Scatter Plot
    p {{ graphRes }}
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'
import { fetchGraphql } from '@/api/graphql.ts'
const gql = String.raw // Dummy gql

@Component
export default class ScatterPlot extends Vue {
  beforeCreate() {
    console.log('ScatterPlot', 'beforeCreate')
    fetchGraphql(
      gql`{ house(id: 1) { datasets { id } } }`
    ).then(res => this.graphRes = res)
  }

  beforeMount() {
    console.log('ScatterPlot', 'beforeMount')
  }

  beforeUpdate() {
    console.log('ScatterPlot', 'beforeUpdate')
  }

  graphRes: {} = {}

  get apollo() {
    const str = gql`
      { house(id: 1) { datasets { id } } }
    `
    return {
      graphRes: {
      }
    }
  }
}
</script>
