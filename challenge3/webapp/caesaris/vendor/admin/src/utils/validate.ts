const emailRegExp = /^([\w+-]\.?)+@[\w\d-]+(\.[\w\d-]+)*\.[a-z]+$/i
export const isValidUsername = (str: string) => emailRegExp.test(str)

export const isExternal = (path: string) => /^(https?:|mailto:|tel:)/.test(path)
