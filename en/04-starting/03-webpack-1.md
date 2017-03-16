> This page covers Tutorial v2. Elm 0.18.

# Webpack

__Elm reactor__ is great for prototyping simple applications, but for a bigger app it falls short. As it is now, __reactor__ doesn't support talking with external JavaScript or importing external CSS. To overcome these issues we will use __Webpack__ to compile our Elm code instead of Elm reactor.

Webpack is a code bundler. It looks at your dependency tree and only bundles the code that is imported. Webpack can also import CSS and other assets inside a bundle. Read more about Webpack [here](https://webpack.github.io/).

There are many alternatives that you can use to achieve the same as Webpack, for example:

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- Or if using a framework like Rails or Phoenix you can bundle the Elm code and CSS using them.

## Requirements

You will need Node JS version 5.1 or more for these libraries to work as expected.

## Installing webpack and loaders

Install webpack and associated packages:

```bash
yarn add webpack webpack-dev-server elm-webpack-loader file-loader style-loader css-loader url-loader
```

This tutorial is using __webpack__ version __2.2__ and __elm-webpack-loader__ version __4.2__.

Loaders are extensions that allow webpack to load different formats. E.g. `css-loader` allows webpack to load .css files.

We also want to use a couple of extra libraries:

- [Basscss](http://www.basscss.com/) for CSS, `ace-css` is the Npm package that bundles common Basscss styles
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/) for icons

```bash
yarn add ace-css@1.1 font-awesome@4
```

## Webpack config

We need to add a __webpack.config.js__ at the root:

```js
var path = require("path");

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    rules: [
      {
        test: /\.(css|scss)$/,
        use: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file-loader?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack-loader?verbose=true&warn=true',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },


};
```

#### Things to note:

- This config creates a Webpack dev server, see the key `devServer`. We will be using this server for development instead of Elm reactor.
- Entry point for our application will be `./src/index.js`, see the `entry` key.
