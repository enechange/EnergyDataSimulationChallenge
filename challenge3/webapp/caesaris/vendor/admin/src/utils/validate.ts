/* eslint-disable comma-dangle */
// export const isValidUsername = (str: string) => ['admin', 'editor'].indexOf(str.trim()) >= 0
const emailRegExp = /^([\w+-]\.?)+@[\w\d-]+(\.[\w\d-]+)*\.[a-z]+$/i
export const isValidUsername = (str: string) => emailRegExp.test(str)

export const isExternal = (path: string) => /^(https?:|mailto:|tel:)/.test(path)
