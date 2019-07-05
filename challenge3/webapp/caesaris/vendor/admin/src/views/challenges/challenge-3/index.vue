<template lang="pug">
  div.contents-area(style='padding:30px;')
    h1.challenge-ttl Challenge 3
    p.challenge-txt Web Application
    tab-area
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import TabArea from './TabArea.vue'

@Component({
  components: { TabArea },
})
export default class Challenge3 extends Vue { }
</script>

<style lang="scss" scoped>
@import "src/styles/challenges.scss";
</style>
