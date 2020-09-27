const { environment } = require('@rails/webpacker')
const typescript =  require('./loaders/typescript')
const babelLoader = environment.loaders.get('babel')

const { options } = babelLoader.use[0];

environment.loaders.prepend('typescript', typescript)

options.presets = [
  [
    '@babel/env',
    {
      targets: {
        node:     'current',
        browsers: ['> 0.25%', 'not op_mini all', 'Explorer 11'],
      },
      useBuiltIns: 'usage',
      corejs:      '3',
    },
  ],
  '@babel/preset-react',
  '@babel/preset-typescript',
];

module.exports = environment
