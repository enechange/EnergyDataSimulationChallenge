import Cookies from 'js-cookie'

const TokenKey = 'authorization'

export const getToken = () => Cookies.get(TokenKey)

export const setToken = (token: string) => Cookies.set(TokenKey, token, { expires: 1 })

export const removeToken = () => Cookies.remove(TokenKey)
