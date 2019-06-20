import request from '@/utils/request'

export const fetchGraphql = async (query: string) => {
  const { data } = await request({
    url: '/graphql',
    method: 'post',
    data: { query }
  })
  return data
}
