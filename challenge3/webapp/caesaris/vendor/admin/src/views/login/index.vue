<template lang="pug">
  .login-container
    el-form.login-form(ref='loginForm', :model='loginForm', :rules='loginRules',
      auto-complete='on', label-position='left')
      h3.title
        | Iuliana Challenges
      el-form-item(prop='username')
        span.svg-container
          svg-icon(name='user')
        el-input(v-model='loginForm.username', name='username', type='text',
          auto-complete='on', placeholder='username')
      el-form-item(prop='password')
        span.svg-container
          svg-icon(name='password')
        el-input(v-model='loginForm.password', :type='pwdType', name='password',
          auto-complete='on', placeholder='password', @keyup.enter.native='handleLogin')
          span.show-pwd(@click='showPwd')
            svg-icon(:name="pwdType === 'password' ? 'eye-off' : 'eye-on'")
      el-form-item
        el-button(:loading='loading', type='primary', style='width:100%;', @click.native.prevent='handleLogin')
          | Sign in
      .tips(v-if="defaultUser")
        span(style='margin-right:20px;')
          i <b>username:</b> {{ defaultUser.username }}
        span
          i <b>password:</b> {{ defaultUser.password }}
</template>

<script lang="ts">
import { isValidUsername } from '@/utils/validate'
import { Component, Vue, Watch } from 'vue-property-decorator'
import { UserModule } from '@/store/modules/user'
import { getDefaultUser } from '@/api/login'
import { Route } from 'vue-router'
import { Form as ElForm } from 'element-ui'

const validateUsername = (rule: any, value: string, callback: any) => {
  if (!isValidUsername(value)) {
    callback(new Error('Enter an Email'))
  } else {
    callback()
  }
}
const validatePass = (rule: any, value: string, callback: any) => {
  if (value.length < 6) {
    callback(new Error('Password must longer than 6'))
  } else {
    callback()
  }
}

@Component
export default class Login extends Vue {
  private loginForm = {
    username: '',
    password: ''
  }
  private defaultUser: { username: string, password: string } | null = null
  private loginRules = {
    username: [{ required: true, trigger: 'blur', validator: validateUsername }],
    password: [{ required: true, trigger: 'blur', validator: validatePass }]
  }
  private loading = false
  private pwdType = 'password'
  private redirect: string | undefined = undefined

  @Watch('$route', { immediate: true })
  private OnRouteChange(route: Route) {
    // TODO: remove the "as string" hack after v4 release for vue-router
    // See https://github.com/vuejs/vue-router/pull/2050 for details
    this.redirect = route.query && route.query.redirect as string
  }

  private showPwd() {
    if (this.pwdType === 'password') {
      this.pwdType = ''
    } else {
      this.pwdType = 'password'
    }
  }

  private handleLogin() {
    (this.$refs.loginForm as ElForm).validate((valid: boolean) => {
      if (valid) {
        this.loading = true
        UserModule.Login(this.loginForm).then(() => {
          this.loading = false
          this.$router.push({ path: this.redirect || '/' })
        }).catch(() => {
          this.loading = false
        })
      } else {
        return false
      }
    })
  }

  private beforeMount() {
    getDefaultUser().then(res => {
      const { data } = res
      if (data && data['email'] && data['password']) {
        this.defaultUser = {
          username: data['email'],
          password: data['password']
        }
        if (process.env.NODE_ENV === 'development') {
          this.loginForm.username = data['email']
          this.loginForm.password = data['password']
        }
      }
    })
  }
}
</script>

<style lang="scss">
@import "src/styles/variables.scss";

.login-container {
  .el-input {
    input {
      background: transparent;
      border: 0px;
      -webkit-appearance: none;
      color: $lightGray;

      &:-webkit-autofill {
        box-shadow: 0 0 0px 1000px $loginBg inset !important;
        -webkit-box-shadow: 0 0 0px 1000px $loginBg inset !important;
        -webkit-text-fill-color: #fff !important;
      }
    }
  }
}
</style>

<style lang="scss" scoped>
@import "src/styles/variables.scss";

.login-container {
  position: fixed;
  height: 100%;
  width: 100%;
  background-color: $loginBg;

  .login-form {
    position: absolute;
    left: 0;
    right: 0;
    width: 520px;
    max-width: 100%;
    padding: 35px 35px 15px 35px;
    margin: 120px auto;
  }

  .el-input {
    display: inline-block;
    width: 85%;
  }

  .el-form-item {
    border: 1px solid rgba(255, 255, 255, 0.1);
    background: rgba(0, 0, 0, 0.1);
    border-radius: 5px;
    color: #454545;
  }

  .tips {
    font-size: 14px;
    color: #fff;
    margin-bottom: 10px;
    span {
      &:first-of-type {
        margin-right: 16px;
      }
    }
  }

  .svg-container {
    padding: 6px 5px 6px 15px;
    color: $darkGray;
    vertical-align: middle;
    width: 30px;
    display: inline-block;
  }

  .title {
    font-size: 26px;
    font-weight: 400;
    color: $lightGray;
    margin: 0px auto 40px auto;
    text-align: center;
    font-weight: bold;
  }

  .show-pwd {
    position: absolute;
    right: 10px;
    top: 7px;
    font-size: 16px;
    color: $darkGray;
    cursor: pointer;
    user-select: none;
  }
}
</style>
