const webpack = require('webpack')
const {resolve, join} = require('path')
const HtmlWebpackPlugin = require('html-webpack-plugin')
const ResourceHintWebpackPlugin = require('resource-hints-webpack-plugin')
const DashboardPlugin = require('webpack-dashboard/plugin')
const ExtractTextPlugin = require('extract-text-webpack-plugin')
const {name: title} = require('./package.json')

const joinPath = (...paths) => join(__dirname, ...paths)
const resolvePath = (...paths) => resolve(__dirname, ...paths)
const resolveSrcPath = (...paths) => resolvePath('src', ...paths)
const resolveDistPath = (...paths) => resolvePath('dist', ...paths)
const isDev = process.env.NODE_ENV !== 'production'
const port = 3000

const plugins = [
  new webpack.EnvironmentPlugin({
    NODE_ENV: 'development',
    DEBUG: isDev
  }),
  new webpack.optimize.UglifyJsPlugin({
    compress: !isDev,
    sourceMap: isDev
  }),
  new webpack.optimize.CommonsChunkPlugin({
    children: true,
    async: true
  }),
  new webpack.LoaderOptionsPlugin({
    minimize: !isDev
  }),
  new HtmlWebpackPlugin({
    title,
    template: resolve('index.ejs')
  }),
  new ResourceHintWebpackPlugin()
]

const elmLoader = [
  {
    loader: 'elm-webpack-loader',
    options: {
      debug: isDev
    }
  }
]

const elmCssLoader = [
  'style-loader',
  'css-loader',
  'elm-css-webpack-loader'
]

let styleExtractor

if (isDev) {
  elmLoader.unshift({
    loader: 'elm-hot-loader'
  })
  plugins.push(
    new DashboardPlugin(),
    new webpack.NamedModulesPlugin(),
    new webpack.HotModuleReplacementPlugin()
  )
} else {
  styleExtractor = new ExtractTextPlugin('main.css')
  plugins.push(styleExtractor)
}

module.exports = {
  devtool: isDev ? 'cheap-eval-module-source-map' : 'cheap-module-source-map',
  devServer: {
    port,
    open: true,
    contentBase: joinPath('dist'),
    hot: true,
    historyApiFallback: true
  },
  entry: resolve('index.js'),
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: [/node_modules/],
        use: 'babel-loader'
      },
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/, /Stylesheets\.elm$/],
        use: elmLoader
      },
      {
        test: /Stylesheets\.elm$/,
        use: styleExtractor !== undefined ? styleExtractor.extract(elmCssLoader) : elmCssLoader
      }
    ]
  },
  output: {
    filename: isDev ? '[name].bundle.js' : '[chunkhash].bundle.js',
    chunkFilename: isDev ? '[name]-[id].chunk.js' : '[chunkhash].chunk.js',
    path: resolveDistPath(),
    publicPath: '/'
  },
  plugins,
  resolve: {
    extensions: [
      '.js',
      '.json',
      '.elm'
    ],
    modules: [
      resolveSrcPath(),
      'node_modules'
    ]
  }
}
