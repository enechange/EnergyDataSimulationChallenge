module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? '/' : '/',

  pwa: {
    name: 'Iuliana Caesaris'
  },

  lintOnSave: process.env.NODE_ENV !== 'production'
}
