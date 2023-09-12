const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    jQuery: 'jquery',
  })
)

environment.loaders.get('sass').use.push('import-glob-loader')

module.exports = environment
