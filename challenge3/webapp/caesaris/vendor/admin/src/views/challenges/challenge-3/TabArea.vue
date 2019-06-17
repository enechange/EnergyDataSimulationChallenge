<template lang="pug">
  el-tabs(v-model='activeName', @tab-click='handleClick')
    el-tab-pane(label='用户管理', name='first') 用户管理
    el-tab-pane(label='配置管理', name='second') 配置管理
    el-tab-pane(label='角色管理', name='third') 角色管理
    el-tab-pane(label='定时任务补偿', name='fourth') 定时任务补偿
</template>

<script lang="ts">
import { Component, Vue, Prop } from 'vue-property-decorator'
import { Component as C } from 'vue'

@Component
export default class TabArea extends Vue {
  activeName: string = 'second'

  handleClick(tab: C, event: MouseEvent) {
    console.log(tab.name, event)
  }
}
</script>
