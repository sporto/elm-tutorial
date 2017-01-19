> This page covers Elm 0.18

# Webpack

__Elm reactor__ 는 간단한 앱을 만들어 보기에는 적합하지만, 더 복잡한 앱을 위해서는 부족합니다. 현재, __reactor__ 는 외부 자바스크립트와 연동하거나 외부 CSS 를 불러오는 기능을 지원하지 않습니다. 대신 여기서는 __Webpack__ 을 사용해 Elm 코드를 구동하는 방식으로 해결합니다.

Webpack 은 코드 번들러입니다. 코드의 의존관계를 살펴서 사용되는 부분만 묶습니다. Webpack 은 CSS 같은 리소스도 번들에 포함할 수 있습니다. Webpack 에 대해서는 [여기](https://webpack.github.io/) 를 참조하세요.

Webpack 과 같은 일을 하는 도구로 다음과 같은 것들도 있습니다:

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- 또는 Rails 나 Phoenix 프레임워크의 경우 자체적인 Elm + CSS 의 번들링 지원

## 필요한 것

이 라이브러리들을 구동하는 데는 Node JS 4 이상의 버전이 필요합니다.

## Webpack 과 로더 (loaders) 설치

Webpack 과 관련 패키지를 설치합니다:

```bash
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@4 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
```

여기서는 __webpack__ 버전 __1.13__ 과 __elm-webpack-loader__ 버전 __4.1__ 을 사용하겠습니다.

로더는 Webpack 이 다양한 포맷을 읽을 수 있게 해주는 일종의 확장입니다. (예: `css-loader` 는 .css 파일을 읽어들임)

몇가지 추가적인 라이브러리도 사용하겠습니다:

- CSS 를 위한 [Basscss](http://www.basscss.com/), `ace-css` npm 패키지에 일반적인 Basscss 스타일이 포함되어 있습니다.
- 아이콘을 위한 [FontAwesome](https://fortawesome.github.io/Font-Awesome/)

```bash
npm i ace-css@1 font-awesome@4 -S
```

## Webpack 설정

루트에 __webpack.config.js__ 를 추가합니다:

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

#### 알아둘 것:

- `devServer` 키에는 Webpack dev 서버에 대한 내용이 있습니다. 이것이 Elm reactor 를 대신합니다.
- `entry` 키의 `./src/index.js` 는 이 어플리케이션의 시작점입니다.
