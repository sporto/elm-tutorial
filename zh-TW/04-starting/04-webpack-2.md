# Webpack 2

## index.html

因為我們不再使用 Elm reactor，所以我們需要自己新增 HTML 來包含應用程式。新增 __src/index.html__：

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

這是 Webpack 在建立綑綁的時候會看的進入點。新增 __src/index.js__：

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// 引入 index.html，這樣才會被複製到 dist 目錄
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// 第三個值放入 embed 的值，是一個初始值給進入埠（incoming ports）到 Elm 使用
var app = Elm.Main.embed(mountNode);
```

## 安裝 Elm 包

執行：

```bash
elm package install elm-lang/html
```

## 程式碼目錄

我們將會把所有程式碼都放在 `src` 目錄底下，所以需要告訴 Elm 去哪兒找相依套件。對 __elm-package.json__ 做修改：

```json
...
"source-directories": [
    "src"
],
...
```

少了這個設定，Elm 編譯器將會試著從專案根目錄開始找起匯入，因此會失敗。

## 初始化 Elm 應用程式

建立一個基本的 Elm 應用程式。修改 __src/Main.elm__：

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App


-- 模型


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- 訊息


type Msg
    = NoOp



-- 視界


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



-- 訂閱


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- 主程式


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

最後，為了更容易執行伺服端，加入一些 npm scripts。修改 __package.json__ 將 `scripts` 替換成：

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- 現在，執行 `npm run api` 便可啟動假的後端伺服端。
- `npm run build` 執行 webpack 建置並將綑綁結果放在 `dist` 目錄。
- `npm run watch` 啟動 webpack 看守，當程式碼異動時，將會把綑綁結果放在 `dist` 目錄。
- `npm run dev` 啟動 webpack 開發伺服端。

## 試試看

讓我們來試試看。

在終端機視窗下執行：

```bash
npm run dev
```

如果你瀏覽 `http://localhost:3000/`，你會看到我們的應用程式輸出 "Hello"。

你的應用程式原始碼會像是 <https://github.com/sporto/elm-tutorial-app/tree/02-webpack>.
