<template lang="pug">
  el-row(:gutter="8")
    el-col.card-box-col(:xs="{span: 24}", :sm="{span: 12}",
      :md="{span: 12}", :lg="{span: 6}" ,:xl="{span: 6}")
      box-card
    el-col.card-box-col(:xs="{span: 24}", :sm="{span: 12}",
      :md="{span: 12}", :lg="{span: 6}" ,:xl="{span: 6}")
      box-card
    el-col.card-box-col(:xs="{span: 24}", :sm="{span: 12}",
      :md="{span: 12}", :lg="{span: 6}" ,:xl="{span: 6}")
      box-card
    el-col.card-box-col(:xs="{span: 24}", :sm="{span: 12}",
      :md="{span: 12}", :lg="{span: 6}" ,:xl="{span: 6}")
      box-card
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import BoxCard from './BoxCard.vue'

@Component({
  components: { BoxCard }
})
export default class CardGroup extends Vue {

}
</script>

<style lang="scss" scoped>
.card-box-col {
  margin-bottom:30px;
}
</style>
