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
      el-form(ref='challenge3Data', :model='challenge3Data', label-width='120px')
        el-col(:span='20')
          el-form-item(label='House Data')
            el-input(v-model='challenge3Data.houseData.url',
              placeholder='https://example.org/house_data.csv')
        el-col.inline-btn(:span='4')
          el-button(type='primary', :loading='challenge3Data.houseData.onloadFlg'
            @click='loadData(challenge3Data.houseData, $event)')
            | {{ challenge3Data.houseData.onloadFlg ? 'Loading...' : 'Load' }}
        el-col(:span='20')
          el-form-item(label='Dataset')
            el-input(v-model='challenge3Data.dataset.url',
              placeholder='https://example.org/dataset_50.csv')
        el-col.inline-btn(:span='4')
          el-button(type='primary', :loading='challenge3Data.dataset.onloadFlg',
            @click='loadData(challenge3Data.dataset, $event)')
            | {{ challenge3Data.dataset.onloadFlg ? 'Loading...' : 'Load' }}
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator'
import { MessageBox, Loading } from 'element-ui'
import { UserModule } from '@/store/modules/user'

interface loadDataItem {
  name: string
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

  private challenge3Data: { [key: string]: loadDataItem } = {
    houseData: {
      name: 'Challenge 3: House Data',
      url: 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/house_data.csv',
      onloadFlg: false,
    },
    dataset: {
      name: 'Challenge 3: Dataset',
      url: 'https://raw.githubusercontent.com/jerrywdlee/EnergyDataSimulationChallenge/master/challenge3/data/dataset_50.csv',
      onloadFlg: false
    },
  }

  private form = {
    name: '',
    region: '',
    date1: '',
    date2: '',
    delivery: false,
    type: [],
    resource: '',
    desc: ''
  };

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

  private loadData(item: loadDataItem, event: MouseEvent) {
    const btn = event.currentTarget as HTMLButtonElement
    item.onloadFlg = true
    this.$message(`Loading ${item.name}`)

    event.preventDefault()
  }

  private onSubmit(event: MouseEvent) {
    console.log(event)
    this.$message('submit!')
  }

  private onCancel() {
    this.$message({
      message: 'cancel!',
      type: 'warning'
    })
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
