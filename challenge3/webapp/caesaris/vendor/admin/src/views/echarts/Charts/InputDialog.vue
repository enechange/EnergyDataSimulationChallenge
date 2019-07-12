<template lang="pug">
  el-dialog.input-data-dialog(
      title='Input Data',
      :visible.sync='dialogVisibleFlg',
    )
    el-form(ref='dataForm', :model='dataForm', :rules='dataFormRules')
      el-form-item(label='Data', prop='rawData')
        el-input.input-data-area(
          type='textarea', v-model='dataForm.rawData',
          :placeholder='placeholder', autocomplete='off',
          :autosize="{ minRows: 10, maxRows: 15}",
        )
    .dialog-footer(slot='footer')
      el-button(@click='dialogVisibleFlg = false') Cancel
      el-button(type='primary', @click='updateData') Show
</template>

<script lang="ts">
import { Component, Vue, Prop, Watch } from 'vue-property-decorator'
import { Form as ElForm } from 'element-ui'

@Component
export default class InputDialog extends Vue {
  @Prop({ default: 0 }) private onOpenFlg!: number
  @Prop({ default: 0 }) private onCloseFlg!: number
  @Prop({ default: '1.23\n2.13\n3.12' }) private placeholder!: string
  private dialogVisibleFlg: boolean = false
  public dataForm = {
    rawData: '',
  }

  private dataFormRules = {
    rawData: [{ required: true, trigger: 'blur', validator: this.rawDataValidator }],
  }

  @Watch('onOpenFlg')
  onOpenEvent(newValue: string, oldValue: string): void {
    this.dialogVisibleFlg = true
  }

  @Watch('onCloseFlg')
  onCloseEvent(newValue: string, oldValue: string): void {
    this.dialogVisibleFlg = false
  }

  updateData() {
    const dataForm = this.$refs.dataForm as ElForm
    dataForm.validate((valid: boolean) => {
      if (valid) {
        this.dialogVisibleFlg = false
        this.$emit('data-change', this.dataForm.rawData)
      }
    })
  }

  private rawDataValidator(rule: any, value: string, callback: any) {
    if (value.length >= 1) {
      callback()
    } else {
      callback(new Error('Data Empty!'))
    }
  }
}
</script>
