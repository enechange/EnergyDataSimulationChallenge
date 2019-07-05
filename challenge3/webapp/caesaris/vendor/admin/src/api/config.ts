import { fetchGraphql } from '@/api/graphql.ts'
const gql = String.raw // Dummy gql

export interface appConfigs {
  general: {
    allowGraphiql: boolean,
  },
  challenge2: {
    totalWattUrl: string,
  },
  challenge3: {
    houseDataUrl: string,
    datasetUrl: string
  },
}

export const initEmptyAppConfigs = () => {
  return {
    general: { allowGraphiql: false },
    challenge2: { totalWattUrl: '' },
    challenge3: { houseDataUrl: '', datasetUrl: '' },
  } as appConfigs
}

export const appConfigsQuery = gql`
  appConfigs {
    general {
      allowGraphiql
    }
    challenge2 {
      totalWattUrl
    }
    challenge3 {
      houseDataUrl
      datasetUrl
    }
  }
`

export const obj2Snippet = (obj: any) =>
  JSON.stringify(obj).replace(/^{|}$|"/g, '')

export const getAppConfig = async (queryString?: string) => {
  const query = queryString || gql`{
    ${appConfigsQuery}
  }`
  const res = await fetchGraphql(query)
  if (res['errors']) {
    throw Error(`${res['errors'][0].message}`)
  }
  return res['data']['appConfigs'] as appConfigs
}

export const setAppConfig = async (updateQuerySnippet = '', queryString?: string) => {
  const query = queryString || gql`
  mutation {
    updateAppConfig(
      input: {
        appConfigs: { ${updateQuerySnippet} }
      }
    ) {
      ${appConfigsQuery}
    }
  }`
  const res = await fetchGraphql(query)
  if (res['errors']) {
    throw Error(`${res['errors'][0].message}`)
  }
  return res['data']['updateAppConfig']['appConfigs'] as appConfigs
}
