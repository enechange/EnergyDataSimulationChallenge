<template lang="pug">
  .sidebar-logo-container(:class="{'collapse':collapse}")
    transition(name='sidebarLogoFade')
      router-link.sidebar-logo-link(v-if='collapse', key='collapse', to='/')
        img.sidebar-logo(v-if='imgUrl', :src='imgUrl')
        h1.sidebar-title(v-else='') {{ title }}
      router-link.sidebar-logo-link(v-else='', key='expand', to='/')
        img.sidebar-logo(v-if='imgUrl', :src='imgUrl')
        h1.sidebar-title {{ title }}
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'

@Component
export default class Logo extends Vue {
  @Prop({ required: true }) private collapse!: boolean;
  @Prop({ default: 'Vue Element Admin' }) private title!: string;

  get imgUrl() {
    return 'https://wpimg.wallstcn.com/69a1c46c-eb1c-4b46-8bd4-e9e686ef5251.png'
  }
}
</script>

<style lang="scss" scoped>
.sidebarLogoFade-enter-active {
  transition: opacity 1.5s;
}

.sidebarLogoFade-enter,
.sidebarLogoFade-leave-to {
  opacity: 0;
}

.sidebar-logo-container {
  position: relative;
  width: 100%;
  height: 50px;
  line-height: 50px;
  background: #2b2f3a;
  text-align: center;
  overflow: hidden;

  & .sidebar-logo-link {
    height: 100%;
    width: 100%;

    & .sidebar-logo {
      width: 27px;
      height: 27px;
      vertical-align: middle;
      margin-right: 8px;
    }

    & .sidebar-title {
      display: inline-block;
      margin: 0;
      color: #fff;
      font-weight: 600;
      line-height: 50px;
      font-size: 13px;
      font-family: Avenir, Helvetica Neue, Arial, Helvetica, sans-serif;
      vertical-align: middle;
    }
  }

  &.collapse {
    .sidebar-logo {
      margin-right: 0px;
    }
  }
}
</style>
