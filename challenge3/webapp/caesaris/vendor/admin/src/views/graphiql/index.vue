<template lang="pug">
  .app-container
    h2 This Module Is Under Construction
  //.app-container
    el-form(ref='form', :model='form', label-width='120px')
      el-form-item(label='Activity name')
        el-input(v-model='form.name')
      el-form-item(label='Activity zone')
        el-select(v-model='form.region', placeholder='please select your zone')
          el-option(label='Zone one', value='shanghai')
            el-option(label='Zone two', value='beijing')
      el-form-item(label='Activity time')
        el-col(:span='11')
          el-date-picker(v-model='form.date1', type='date', placeholder='Pick a date', style='width: 100%;')
        el-col.line(:span='2')
          | -
        el-col(:span='11')
          el-time-picker(v-model='form.date2', type='fixed-time', placeholder='Pick a time', style='width: 100%;')
      el-form-item(label='Instant delivery')
        el-switch(v-model='form.delivery')
      el-form-item(label='Activity type')
        el-checkbox-group(v-model='form.type')
          el-checkbox(label='Online activities', name='type')
            el-checkbox(label='Promotion activities', name='type')
              el-checkbox(label='Offline activities', name='type')
                el-checkbox(label='Simple brand exposure', name='type')
      el-form-item(label='Resources')
        el-radio-group(v-model='form.resource')
          el-radio(label='Sponsor')
            el-radio(label='Venue')
      el-form-item(label='Activity form')
        el-input(v-model='form.desc', type='textarea')
      el-form-item
        el-button(type='primary', @click='onSubmit')
          | Create
        el-button(@click='onCancel')
          | Cancel
</template>

<script lang="ts">
// TODO: Use this https://github.com/graphql/graphiql/tree/master/packages/codemirror-graphql#readme
import { Component, Vue } from 'vue-property-decorator'
import { MessageBox } from 'element-ui'

@Component
export default class Form extends Vue {
  private form = {
    name: '',
    region: '',
    date1: '',
    date2: '',
    delivery: false,
    type: [],
    resource: '',
    desc: '',
  };

  mounted() {
    MessageBox.alert('This Feature Is Under Development.', {
      confirmButtonText: 'OK',
    }).then(() => {
      this.$router.push({ path: '/' })
    }).catch(() => { /* Handle `cancel` Action */ })
  }

  private onSubmit() {
    this.$message('submit!')
  }

  private onCancel() {
    this.$message({
      message: 'cancel!',
      type: 'warning',
    })
  }
}
</script>

<style lang="scss" scoped>
.line {
  text-align: center;
}
</style>
