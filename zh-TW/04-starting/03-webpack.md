# Webpack

__Elm reactor__ 非常適合快速製造簡單的應用程式原型，但對於大一點的應用程式就略顯不足。現在就是了，__reactor__ 不支援與外部 JavaScript 溝通或匯入外部 CSS。為了解決這個問題，我們使用 __Webpack__ 來編譯 Elm 程式碼，取代原本的 Elm reactor。

Webpack 是個程式碼綑綁器（code bundler）。它會查看你的相依樹（dependency tree）並綑綁被匯入的程式碼。Webpack 也會匯入 CSS 及其他檔案資產。更多關於 Webpack 請參考[這裡](https://webpack.github.io/)。

除了 Webpack 之外，也有許多替代方案，例如：

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- 或使用像是 Rails 或 Phoenix 之類的框架，你也可以用來綑綁 Elm 程式碼與 CSS。

## 基本需求

需要安裝 Node JS 版本 4 以上，這些函式庫才會如期運作。

## 安裝 webpack 及加載器（loaders）

安裝 webpack 及附屬包：

```bash
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@3 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
```

本課程使用 __webpack__ 版本 __1.13__ 及 __elm-webpack-loader__ 版本 __3.0__。

加載器是一種外掛，讓 webpack 能夠加載各種不同的檔案格式。例如：`css-loader` 讓 webpack 能夠加載 .css 檔案。

我們也希望使用幾個額外的函式庫：

- [Basscss](http://www.basscss.com/) 給 CSS 使用，`ace-css` 是一個 npm 包，用來綑綁共用的 Basscss 樣式
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/) 為了使用圖示（icons）。

```bash
npm i ace-css@1 font-awesome@4 -S
```

## Webpack 配置

在專案根目錄底下新增 __webpack.config.js__ 檔案：

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
    loaders: [
      {
        test: /\.(css|scss)$/,
        loaders: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack',
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

#### 注意事項：

- 配置中加入了 Webpack dev server，請見 `devServer` 鍵值。使用這個伺服端來取代 Elm reactor。
- 應用程式的進入點為 `./src/index.js`，請見 `entry` 鍵。
