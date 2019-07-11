<template lang="pug">
  div.contents-area(style='padding:30px;')
    h1.challenge-ttl Echarts Playground
    p.challenge-txt Visualization of Given Data
    el-tabs(v-model='activeName')
      el-tab-pane.tab-panel(label='Histogram', name='histogram', lazy=true)
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'

@Component
export default class EchartsPlayground extends Vue {
  private activeName: string = 'histogram'
}
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";
</style>
