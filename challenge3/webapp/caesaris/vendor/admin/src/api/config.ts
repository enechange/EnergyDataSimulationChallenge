import { fetchGraphql } from '@/api/graphql.ts'
const gql = String.raw // Dummy gql

export interface appConfigs {
  challenge2: {
    totalWattUrl: string,
  },
  challenge3: {
    houseDataUrl: string,
    datasetUrl: string
  },
}

export const getAppConfig = async (queryString = null) => {
  const query = queryString || gql`{
    appConfigs {
      challenge2 {
        totalWattUrl,
      },
      challenge3 {
        houseDataUrl,
        datasetUrl,
      },
    }
  }`
  const res = await fetchGraphql(query)
  return res['data']['appConfigs'] as appConfigs
}
