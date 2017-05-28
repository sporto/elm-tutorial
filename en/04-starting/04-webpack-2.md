> This page covers Tutorial v2. Elm 0.18.

# Webpack 2

## index.html

As we are not using Elm reactor anymore we will need to create our own HTML for containing the application. Create __src/index.html__:

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

This is the entry point that Webpack will look for when creating a bundle. Add __src/index.js__:

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);
```

## Install Elm packages

Run:

```bash
elm-package install elm-lang/html
```

After doing this there should be a file called __elm-package.json__ in the root of your project.

## Source directory

We will be adding all our source code in the `src` folder, so we need to tell Elm where to search for dependencies. In __elm-package.json__ change:

```json
...
"source-directories": [
    "src"
],
...
```

Without this the Elm compiler will try to find the imports in the root of our project and fail.
