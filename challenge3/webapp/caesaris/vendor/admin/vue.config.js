module.exports = {
  publicPath: process.env.NODE_ENV === 'production' ? '/' : '/',

  pwa: {
    name: process.env.VUE_APP_NAME || 'Iuliana Challenges',
  },

  lintOnSave: process.env.NODE_ENV !== 'production',
}
