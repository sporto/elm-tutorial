> 本頁包含 Elm 0.18

# Webpack 2

## index.html

因為不再使用 Elm reactor，所以需要新增 HTML 來引入應用程式。新增 __src/index.html__：

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

這是 Webpack 建立綑綁的進入點。新增 __src/index.js__：

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// 引入 index.html，這樣才會被複製到 dist 目錄
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// 第三個放入 embed 的值是程式初始值，例如 userID 或 token。
var app = Elm.Main.embed(mountNode);
```

## 安裝 Elm 包

執行：

```bash
elm-package install elm-lang/html
```

## 程式碼目錄

將所有程式碼都放在 `src` 目錄底下，需要告訴 Elm 去哪找相依套件。對 __elm-package.json__ 做修改：

```json
...
"source-directories": [
    "src"
],
...
```

少了這個設定，Elm 編譯器將會試著從專案根目錄開始找起匯入，因此會失敗。
