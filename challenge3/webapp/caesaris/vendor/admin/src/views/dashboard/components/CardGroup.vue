<template lang="pug">
  el-row(:gutter="8")
    el-col.card-box-col(v-for="(cardInfo, index) of cardInfos",
      :key="index", :xs="{span: 24}", :sm="{span: 12}",
      :md="{span: 12}", :lg="{span: 6}" ,:xl="{span: 6}")
      router-link(v-if="cardInfo.target", :to="cardInfo.target")
        box-card(:card-info="cardInfo")
      a(v-else, href="javascript:void(0)", @click="noFeature()")
        box-card(:card-info="cardInfo")
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { MessageBox } from 'element-ui'
import BoxCard from './BoxCard.vue'

@Component({
  components: { BoxCard }
})
export default class CardGroup extends Vue {
  @Prop({ default: [] }) private cardInfos!: [{
    title: string, text: string, target: string, imgUrl?: string
  }];

  private noFeature() {
    MessageBox.alert('This Feature Is Under Development.', {
      confirmButtonText: 'OK'
    })
    // alert('This Feature Is Under Development.')
  }
}
</script>

<style lang="scss" scoped>
.card-box-col {
  margin-bottom:30px;
}
</style>
