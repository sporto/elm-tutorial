>このページでは、Elm 0.17

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

## 最初のElmアプリケーション

基本的なElmアプリケーションを作成します。 __src/Main.elm__では：

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App

-- モデル


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- メッセージ


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- 更新


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- サブスクリプション(購読)


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never
main =
    Html.App.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
```

## package.json

最後に、npmスクリプトを追加して、サーバを簡単に実行できるようにします。 __package.json__で `scripts`を以下のように置き換えてください：

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- これで `npm run api`がフェイクのサーバーを実行します。
- `npm run build`はwebpackビルドを作成し、バンドルを`dist`に入れます。
- `npm run watch`はwebpackウォッチャーを実行し、ソースコードを変更するときにバンドルを`dist`に入れます。
- `npm run dev`はwebpack devサーバを実行します。

## テストする

セットアップをテストしましょう。

ターミナルウィンドウで以下を実行します：

```bash
npm run dev
```

`http://localhost:3000/`を参照すると、アプリケーションが表示され、 "Hello"が出力されます。

アプリケーションコードは<https://github.com/sporto/elm-tutorial-app/tree/02-webpack>のようになります。
