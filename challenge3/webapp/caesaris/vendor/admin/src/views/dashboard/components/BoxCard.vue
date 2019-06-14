<template lang="pug">
  el-card.box-card-component(:class="{'card-disabled': notReadyFlg}")
    .box-card-header(slot="header")
      img(src="https://picsum.photos/600/400/?random")
    .box-card-body
      p {{ title }}
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'

@Component
export default class BoxCard extends Vue {
  @Prop({ default: {} }) private cardInfo!: { title: string, target: string };

  get notReadyFlg() {
    return !this.cardInfo.target
  }

  get title() {
    if (this.notReadyFlg) {
      return `${this.cardInfo.title} (Not Ready)`
    } else {
      return this.cardInfo.title
    }
  }
}
</script>

<style lang="scss" >
.box-card-component{
  .el-card__header {
    padding: 0px!important;
  }
}
</style>

<style lang="scss" scoped>
.box-card-component {
  margin-left:8px;
  &.card-disabled {
    opacity: .6;
  }
  .box-card-header {
    position: relative;
    height: 220px;
    img {
      width: 100%;
      height: 100%;
      transition: all 0.2s linear;
      &:hover {
        transform: scale(1.1, 1.1);
        filter: contrast(130%);
      }
    }
  }
  .box-card-body {
    position:relative;
  }
}
</style>
