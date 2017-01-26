> This page covers Elm 0.18

# Webpack 2

## index.html

Elm reactor 를 사용하지 않으므로 앱을 구동하는 HTML 을 직접 만들어야 합니다. __src/index.html__ 을 작성합니다:

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

Webpack 이 번들 작성을 위해 진입하는 곳입니다. __src/index.js__ 를 작성합니다:

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// index.html 를 require 하여 dist 에 복사 되도록 한다.
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() 는 두번째 인자를 받을 수 있다. 이는 프로그램에 필요한 데이터가 될 수 있다. (예: userID, 토큰 등)
var app = Elm.Main.embed(mountNode);
```

## Elm 패키지 설치

터미널에서 아래 명령을 실행합니다:

```bash
elm package install elm-lang/html
```

## 소스 디렉터리

모든 소스코드는 `src` 폴더에 넣을 겁니다. 이를 Elm 에 알려주기 위해 __elm-package.json__ 을 수정합니다:

```json
...
"source-directories": [
    "src"
],
...
```

이렇게 하지 않으면 Elm 컴파일러는 폴더 루트에서 임포트할 대상을 찾으려 하고 실패하게 될 겁니다.
