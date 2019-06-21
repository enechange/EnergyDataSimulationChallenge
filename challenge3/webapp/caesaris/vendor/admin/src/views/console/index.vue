<template lang="pug">
  .app-container
    h1.module-ttl Active Console
    .inner-container
      h2.inner-container-ttl Create User
      el-form(ref='userForm', :model='userForm', label-width='120px')
        el-col(:span='8')
          el-form-item(label='User name')
            el-input(v-model='userForm.email', type='email',
              name='email', placeholder='user@example.org')
        el-col(:span='8')
          el-form-item(label='Password')
            el-input(v-model='userForm.password', show-password,
              name='password', placeholder='P@ssword')
        el-col(:span='8')
          el-form-item(label='Roles')
            el-select(v-model='userForm.roles', placeholder='Select Roles', multiple, collapse-tags)
              el-option(v-for='role in userForm.roleList',
                :label='role.toUpperCase()', :key='role', :value='role')
        el-col(:span='24')
          el-form-item
            el-button(type='primary', @click='onSubmit')
              | Create
            el-button(@click='onCancel')
              | Cancel
    .inner-container
      h2.inner-container-ttl Load Data
      h3.inner-container-subttl Challenge 3
      el-form(ref='challenge3Data', :model='challenge3Data', label-width='120px', :rules='challenge3DataRules')
        el-col(:span='23')
          el-form-item(label='House Data', prop='houseDataUrl')
            el-input(v-model='challenge3Data.houseDataUrl', :disabled='challenge3Data.onloadFlg'
              placeholder='https://example.org/house_data.csv')
        el-col(:span='23')
          el-form-item(label='Dataset', prop='datasetUrl')
            el-input(v-model='challenge3Data.datasetUrl', :disabled='challenge3Data.onloadFlg'
              placeholder='https://example.org/dataset_50.csv')
        el-col(:span='24')
          el-form-item
            el-button(type='primary', :loading='challenge3Data.onloadFlg',
              @click='loadChallenge3Data')
              | {{ challenge3Data.onloadFlg ? 'Loading...' : 'Load CSV' }}
</template>

<script lang="ts">
/* eslint-disable no-useless-escape */
/* eslint-disable comma-dangle */
import { Component, Vue } from 'vue-property-decorator'
import { MessageBox, Loading, Form as ElForm } from 'element-ui'
import { UserModule } from '@/store/modules/user'
import request from '@/utils/request'

interface loadDataItem {
  name: string,
  key: string,
  url: string,
  onloadFlg: boolean,
}

@Component
export default class Form extends Vue {
  private userForm = {
    email: '',
    password: '',
    roles: [],
    roleList: [ 'admin', 'editor', 'observer' ],
  }

  private challenge3Data = {
    key: 'challenge-3',
    houseDataUrl: 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv',
    datasetUrl: 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv',
    onloadFlg: false,
  }

  private challenge3DataRules = {
    houseDataUrl: [{ required: true, trigger: 'blur', validator: this.urlValidator }],
    datasetUrl: [{ required: true, trigger: 'blur', validator: this.urlValidator }],
  }

  mounted() {
    const roles = UserModule.roles.map((r: string) => r.toString().toLowerCase())
    if (!roles.includes('admin')) {
      MessageBox.alert('Only Admin User Are Allowed.', {
        confirmButtonText: 'OK'
      }).then(() => {
        this.$router.push({ path: '/' })
      })
    }
  }

  private loadChallenge3Data(event: MouseEvent) {
    event.preventDefault()

    const challenge3Data = this.$refs.challenge3Data as ElForm
    const postData = {
      url: '/api/load_csv',
      method: 'post',
      data: {
        key: this.challenge3Data.key,
        house_data_url: this.challenge3Data.houseDataUrl,
        dataset_url: this.challenge3Data.datasetUrl,
      }
    }

    challenge3Data.validate((valid: boolean) => {
      if (valid) {
        this.challenge3Data.onloadFlg = true
        this.$message(`Loading Challenge 3 Data`)
        request(postData).then(res => {
          const { data } = res
          if (data.result === 'ok') {
            this.$message({
              message: 'Challenge 3 Data Loaded!',
              type: 'success',
            })
          }
          this.challenge3Data.onloadFlg = false
        }).catch(err => {
          console.log(err)
          this.challenge3Data.onloadFlg = false
        })
        return true
      } else {
        this.$message({
          message: 'Invalid Data!',
          type: 'error'
        })
        return false
      }
    })
  }

  private onSubmit(event: MouseEvent) {
    this.$message('submit!')
  }

  private onCancel() {
    this.$message({
      message: 'cancel!',
      type: 'warning'
    })
  }

  private urlValidator(rule: any, value: string, callback: any) {
    const urlRegExp = /(https?|ftp)(:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)/
    if (urlRegExp.test(value)) {
      callback()
    } else {
      callback(new Error('Invalid URL!'))
    }
  }
}
</script>

<style lang="scss" scoped>
h1, h2, h3, h4, p {
  color: #333
}

.module-ttl {
  text-align: center;
  margin-top: 5px;
  margin-bottom: 20px;
}

.inner-container {
  padding: 10px;
  display: flex;
  flex-direction: column;
  .inner-container-ttl, .inner-container-subttl {
    display: block;
    width: 100%;
    padding-left: 20px;
    padding-right: 20px;
  }
  .inner-container-subttl {
    margin-top: 10px;
  }
  .el-form {
    display: block;
    width: 100%;
  }
  .inline-btn {
    padding-left: 25px;
    padding-right: 25px;
  }
}

.line {
  text-align: center;
}
</style>
