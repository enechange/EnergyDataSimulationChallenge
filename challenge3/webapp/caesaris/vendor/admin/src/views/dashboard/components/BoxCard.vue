<template>
  <el-card class="box-card-component">
    <div
      slot="header"
      class="box-card-header"
    >
      <img src="https://picsum.photos/600/400/?random">
    </div>
    <div style="position:relative;">
      AAAAA
    </div>
  </el-card>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'

@Component
export default class BoxCard extends Vue {

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
}
</style>
