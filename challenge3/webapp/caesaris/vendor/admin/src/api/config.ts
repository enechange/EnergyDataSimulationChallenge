import request from '@/utils/request'

export const getAppConfig = () =>
  request({
    url: '/api/app_config',
    method: 'get',
  })
