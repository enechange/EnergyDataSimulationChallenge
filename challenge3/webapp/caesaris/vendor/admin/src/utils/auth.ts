import Cookies from 'js-cookie'

const TokenKey = 'authorization'

export const getToken = () => Cookies.get(TokenKey)

export const setToken = (token: string) => Cookies.set(TokenKey, token, { expires: 1 })

export const removeToken = () => Cookies.remove(TokenKey)

const CsrfTokenKey = 'x-authenticity-token'

export const getCsrfToken = () => Cookies.get(CsrfTokenKey)

export const setCsrfToken = (token: string) =>
  Cookies.set(CsrfTokenKey, token, { expires: 1 })

export const removeCsrfToken = () => Cookies.remove(CsrfTokenKey)
