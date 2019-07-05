import axios from 'axios'
import { Message, MessageBox } from 'element-ui'
import { getToken, setToken, getCsrfToken, setCsrfToken } from '@/utils/auth'
import { UserModule } from '@/store/modules/user'

let baseURL = process.env.VUE_APP_MOCK_API

switch (process.env.NODE_ENV) {
  case 'development':
    baseURL = 'http://localhost:18000/'
    break
  case 'test':
    baseURL = process.env.VUE_APP_MOCK_API
    break
  case 'production':
  default:
    baseURL = process.env.RAILS_API_URL || ''
    break
}

export const getBaseURL = () => {
  return baseURL || ''
}

const service = axios.create({
  baseURL,
  timeout: 5000,
})

// Request interceptors
service.interceptors.request.use(
  (config) => {
    // Add X-Token header to every request, you can add other custom headers here
    config.headers['X-Requested-With'] = 'XMLHttpRequest'

    // const method = (config.method || '').toLowerCase()
    // if (method === 'post' && config.data) {
    //   const csrfAuthToken = getCsrfToken()
    //   if (csrfAuthToken) {
    //     config.data['authenticity_token'] = csrfAuthToken
    //   }
    // }

    if (UserModule.token) {
      // For JWT Authorization
      config.headers['Authorization'] = getToken()
    }
    return config
  },
  (error) => {
    handleResponseError(422, error.message)
    Promise.reject(error)
  }
)

// Response interceptors
service.interceptors.response.use(
  (response) => {
    // Some example codes here:
    // code == 20000: valid
    // code == 50008: invalid token
    // code == 50012: already login in other place
    // code == 50014: token expired
    // code == 60204: account or password is incorrect
    // You can change this part for your own usage.
    const res = response.data
    const { headers } = response
    const currentToken = getToken()
    const newToken: string = headers['authorization']
    if (newToken && currentToken !== newToken) {
      setToken(newToken)
      UserModule.RefreshToken(newToken)
    }
    // const CsrfAuthToken: string = headers['x-authenticity-token']
    // setCsrfToken(CsrfAuthToken)
    if (res.code !== 20000 && response.status !== 200) {
      const code = res.code || response.status
      handleResponseError(code, res.message)
      return Promise.reject(new Error('error with code: ' + code))
    } else {
      return response
    }
  },
  (error) => {
    const { response } = error
    const { data } = response
    const code = response.status
    const message: string = data.error || error.message
    Message({
      message: message,
      type: 'error',
      duration: 5 * 1000,
    })
    handleResponseError(code, message)
    return Promise.reject(error)
  }
)

function handleResponseError(statusCode: number, message = 'System Error!') {
  Message({
    message,
    type: 'error',
    duration: 5 * 1000,
  })
  if (authFailed(statusCode, message)) {
    MessageBox.confirm(
      'You need to login before continuing.',
      'Logout',
      {
        confirmButtonText: 'Login',
        cancelButtonText: 'Cancel',
        type: 'warning',
      }
    ).then(() => {
      UserModule.FedLogOut().then(() => {
        location.reload() // To prevent bugs from vue-router
      })
    }).catch(() => { /* Handle `cancel` Action */ })
  }
}

function authFailed(statusCode: number, errorMsg = '') {
  const codes = [50008, 50012, 50014, 401, 422]
  if (codes.includes(statusCode)) {
    if (errorMsg) {
      errorMsg = errorMsg.toLowerCase()
      if (errorMsg.includes('email') || errorMsg.includes('password')) {
        return
      }
    }
    return true
  }
}

export default service
