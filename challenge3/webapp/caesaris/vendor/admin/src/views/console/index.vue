<template lang="pug">
  .app-container
    h1.module-ttl Active Console
    .inner-container
      h2.inner-container-ttl Create User
      el-form(ref='userForm', :model='userForm', label-width='120px', :rules='userFormRules')
        el-col(:span='8')
          el-form-item(label='User name', prop='email')
            el-input(v-model='userForm.email', type='email',
              name='email', placeholder='user@example.org', :disabled='userForm.onloadFlg')
        el-col(:span='8')
          el-form-item(label='Password', prop='password')
            el-input(v-model='userForm.password', show-password,
              name='password', placeholder='P@ssword', :disabled='userForm.onloadFlg')
        el-col(:span='8')
          el-form-item(label='Roles', prop='roles')
            el-select(v-model='userForm.roles', placeholder='Select Roles',
              :disabled='userForm.onloadFlg', multiple, collapse-tags)
              el-option(v-for='role in userForm.roleList',
                :label='role.toUpperCase()', :key='role', :value='role')
        el-col(:span='24')
          el-form-item
            el-button(type='primary', @click='createUser', :loading='challenge3Data.onloadFlg')
              | Create User
            // el-button(@click='onCancel')
              | Cancel
    .inner-container
      h2.inner-container-ttl Load Data
      h3.inner-container-subttl
        | Challenge 2
        p.inner-container-des Set Total Watt CSV Path
      el-form(ref='challenge2Data', :model='challenge2Data', label-width='120px', :rules='challenge2DataRules')
        el-col(:span='23')
          el-form-item(label='Total Watt', prop='totalWattUrl')
            el-input(v-model='challenge2Data.totalWattUrl', :disabled='challenge2Data.onloadFlg'
              placeholder='https://example.org/total_watt.csv')
        el-col(:span='24')
          el-form-item
            el-button(type='primary', :loading='challenge2Data.onloadFlg',
              @click='setChallenge2Url')
              | {{ challenge2Data.onloadFlg ? 'Loading...' : 'Setup Data URL' }}
      br/
      h3.inner-container-subttl
        | Challenge 3
        p.inner-container-des Load Data From CSV Files
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
              | {{ challenge3Data.onloadFlg ? 'Loading...' : 'Load Data From CSV' }}
</template>

<script lang="ts">
/* eslint-disable no-useless-escape */
import { Component, Vue } from 'vue-property-decorator'
import { MessageBox, Loading, Form as ElForm } from 'element-ui'
import { UserModule } from '@/store/modules/user'
import { isValidUsername } from '@/utils/validate'
import request from '@/utils/request'
import { getAppConfig, setAppConfig } from '@/api/config.ts'

@Component
export default class Form extends Vue {
  private userForm = {
    email: '',
    password: '',
    roles: [],
    roleList: [ 'admin', 'editor', 'observer' ],
    onloadFlg: false,
  }

  private userFormRules = {
    email: [{ required: true, trigger: 'blur', validator: this.emailValidator }],
    password: [{ required: true, trigger: 'blur', validator: this.passwordValidator }],
    roles: [{ required: true, trigger: 'change', validator: this.rolesValidator }],
  }

  private challenge2Data = {
    key: 'challenge-2',
    totalWattUrl: '',
    onloadFlg: false,
  }

  private challenge2DataRules = {
    totalWattUrl: [{ required: true, trigger: 'blur', validator: this.urlValidator }],
  }

  private challenge3Data = {
    key: 'challenge-3',
    houseDataUrl: '',
    datasetUrl: '',
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
        confirmButtonText: 'OK',
      }).then(() => {
        this.$router.push({ path: '/' })
      }).catch(() => { /* Handle `cancel` Action */ })
    } else {
      this.updateAppConfigs()
    }
  }

  private updateAppConfigs() {
    const { challenge2, challenge3 } = UserModule.appConfigs
    Object.assign(this.challenge2Data, challenge2)
    Object.assign(this.challenge3Data, challenge3)
  }

  private createUser(event: MouseEvent) {
    event.preventDefault()

    const userForm = this.$refs.userForm as ElForm
    const postData = {
      url: '/api/create_user',
      method: 'post',
      data: {
        email: this.userForm.email,
        password: this.userForm.password,
        roles: this.userForm.roles,
      },
    }

    userForm.validate(async (valid: boolean) => {
      if (valid) {
        this.userForm.onloadFlg = true
        this.$message(`Loading Challenge 3 Data`)
        try {
          const { data } = await request(postData)
          if (data.id) {
            this.$message.success(`User [${data.id}] Created!`)
          }
        } catch (e) {
          console.error(e)
        } finally {
          this.userForm.onloadFlg = false
        }
      } else {
        this.$message.error('Invalid Data!')
        return false
      }
    })
  }

  private onCancel() {
    this.$message({
      message: 'cancel!',
      type: 'warning',
    })
  }

  private setChallenge2Url(event: MouseEvent) {
    event.preventDefault()

    const challenge2DataForm = this.$refs.challenge2Data as ElForm
    challenge2DataForm.validate(async (valid: boolean) => {
      if (valid) {
        const { totalWattUrl } = this.challenge2Data
        const querySnippet = `
          challenge2: {
            totalWattUrl: "${totalWattUrl}"
          }
        `
        try {
          const appConfigs = await setAppConfig(querySnippet)
          UserModule.UpdateAppConfigs(appConfigs)
          this.$message.success('Challenge 2 Total Watt Url Saved!')
        } catch (error) {
          this.$message.error(error.message)
        }
      } else {
        this.$message.error('Invalid Data!')
        return false
      }
    })
  }

  private loadChallenge3Data(event: MouseEvent) {
    event.preventDefault()

    const postData = {
      url: '/api/load_csv',
      method: 'post',
      data: {
        key: this.challenge3Data.key,
        house_data_url: this.challenge3Data.houseDataUrl,
        dataset_url: this.challenge3Data.datasetUrl,
      },
    }

    const challenge3DataForm = this.$refs.challenge3Data as ElForm
    challenge3DataForm.validate((valid: boolean) => {
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
          console.error(err)
          this.challenge3Data.onloadFlg = false
        })
        return true
      } else {
        this.$message({
          message: 'Invalid Data!',
          type: 'error',
        })
        return false
      }
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

  private emailValidator(rule: any, value: string, callback: any) {
    if (isValidUsername(value)) {
      callback()
    } else {
      callback(new Error('Enter an Email!'))
    }
  }

  private passwordValidator(rule: any, value: string, callback: any) {
    const passwordSizeMin = 6
    if (value.length >= passwordSizeMin) {
      callback()
    } else {
      callback(new Error(`Must has ${passwordSizeMin} or more`))
    }
  }

  private rolesValidator(rule: any, value: [string], callback: any) {
    if (value.length >= 1) {
      callback()
    } else {
      callback(new Error('Select at least 1 role'))
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
  .inner-container-des {
    padding-left: 20px;
    display: inline-block;
    margin-top: 0;
    font-size: 14px;
    font-weight: normal;
    font-style: italic;
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
