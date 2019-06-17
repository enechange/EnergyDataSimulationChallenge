const rootPath = process.env.NODE_ENV === 'production' ? '/' : 'http://localhost:18000/'

export const fetchGraphql = (query: string) =>
  fetch(`${rootPath}graphql`, {
    method: 'POST',
    body: JSON.stringify({ query }),
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  }).then(res => res.json())
