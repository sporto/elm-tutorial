>このページでは、Elm 0.18

# Webpackその2

## index.html

Elm reactorを使用していないので、アプリケーションを格納するために独自のHTMLを作成する必要があります。 __src/index.html__を以下の内容で作成します：

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Elm SPA example</title>
  </head>
  <body>
    <div id="main"></div>
    <script src="/app.js"></script>
  </body>
</html>
```

## index.js

これは、Webpackがバンドルを作成するときに探すエントリポイントです。 __src/index.js__を追加：

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// index.htmlがdistにコピーされるようにRequireする
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed()はオプションの第二引数を取り、プログラム開始に必要なデータを与えられる。たとえばuserIDや何らかのトークンなど
var app = Elm.Main.embed(mountNode);
```

## Elmパッケージをインストールする

以下を実行します：

```bash
elm package install elm-lang/html
```

## ソースディレクトリ

すべてのソースコードを `src`フォルダに追加するので、Elmに依存関係を検索する場所を指定する必要があります。 __elm-package.json__を以下のように変更します：

```json
...
"source-directories": [
    "src"
],
...
```

これがなければ、Elmコンパイラはプロジェクトのルートにあるインポートを見つけようとします。
