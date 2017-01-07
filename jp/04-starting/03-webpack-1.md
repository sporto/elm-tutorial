> This page covers Elm 0.18

# Webpackその1

__Elm reactor__は単純なアプリケーションのプロトタイプ作成には最適ですが、より大きなアプリケーションでは不足です。今のところ、__reactor__は外部JavaScriptとの会話や外部CSSの読み込みをサポートしていません。これらの問題を解決するために、__Webpack__を使用してElmの代わりにElmコードをコンパイルします。

Webpackはコードを束ねるためのツール(バンドラー)です。それはあなたの依存関係の木を見て、インポートされたコードだけを束ねます。Webpackは、バンドル内のCSSやその他のアセットをインポートすることもできます。 Webpackの詳細は[こちら](https://webpack.github.io/)にあります。

Webpackと同じように実現するために使用できる多くの選択肢があります。たとえば、次のようなものがあります。

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- あるいは、RailsやPhoenixのようなフレームワークを使用している場合は、ElmコードとCSSをバンドルすることができます。

## 要件

これらのライブラリが期待通りに機能するには、Node JS version 4以上が必要です。

## Webpackとローダのインストール

Webpackと関連パッケージをインストールする：

```bash
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@4 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
```

このチュートリアルでは、__webpack__バージョン__1.13__と__elm-webpack-loader__バージョン__4.1__を使用しています。

ローダーは、Webpackが異なるフォーマットをロードできるようにする拡張機能です。例えば。 `css-loader`はwebpackに.cssファイルをロードさせます。

また、いくつかのライブラリを追加したいと思っています：

- CSS用の[Basscss](http://www.basscss.com/)、 `ace-css`は、一般的なBasscssスタイルをバンドルするNpmパッケージです
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/)のアイコン

```bash
npm i ace-css@1 font-awesome@4 -S
```

## Webpackの設定

ルートに__webpack.config.js__を追加する必要があります：

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
        loader:  'elm-webpack?verbose=true&warn=true',
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

#### 留意事項：

- この設定は、Webpack devサーバを作成します。キー `devServer`を参照してください。 Elm reactorの代わりにこのサーバを開発用に使用します。
- アプリケーションのエントリーポイントは `./src/index.js`です、`entry`キーを見てください。
