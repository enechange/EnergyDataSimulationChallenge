import request from '@/utils/request'

export const login = (username: string, password: string) =>
  request({
    url: '/users/sign_in',
    method: 'post',
    data: {
      user: {
        email: username,
        password,
      },
    },
  })

export const getUserInfo = (token: string) =>
  request({
    url: '/api/user_info',
    method: 'get',
    params: { },
  })

export const getDefaultUser = () =>
  request({
    url: '/api/default_user',
    method: 'get',
  })

export const logout = () =>
  request({
    url: '/users/sign_out',
    method: 'delete',
  })
