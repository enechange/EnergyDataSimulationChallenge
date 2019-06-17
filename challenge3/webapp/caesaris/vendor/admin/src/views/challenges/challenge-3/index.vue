<template lang="pug">
  div.contents-area(style='padding:30px;')
    h1.challenge-ttl Challenge 3
    p.challenge-txt Web Application
    //el-alert(:closable='false', title='Challenge 3')
    <tab-area />
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import TabArea from './TabArea.vue'

@Component({
  components: { TabArea }
})
export default class Challenge3 extends Vue {

}
</script>

<style lang="scss" scoped>
.contents-area {
  padding:30px;
  .challenge-ttl {
    font-size: 1.5em;
    margin-top: 0;
    margin-bottom: 10px;
    color: #333;
  }

  .challenge-txt {
    margin-top: 10px;
    color: #333;
  }
}
</style>
