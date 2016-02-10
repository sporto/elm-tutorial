# Webpack

__Elm reactor__ is great for prototyping simple applications, but for a bigger app it falls short. At the moment __reactor__ won't let us send talk with external JavaScript and won't let us import external CSS. To fix this we will be compiling our Elm code ourselves using __Webpack__.

Webpack is a code bundler. It looks at your dependency tree and only bundles the code that is imported. Webpack can also import CSS and other assets inside a bundle. Read more about Webpack [here](https://webpack.github.io/).


## Installing webpack and loaders

Stop Elm reactor if running and install webpack:

```bash
npm i webpack webpack-dev-middleware elm-webpack-loader file-loader style-loader css-loader url-loader -S
```

This tutorial is using __webpack__ version __1.12__ and __elm-webpack-loader__ version __2.0__.

Loaders are extensions that allow webpack to load different formats. E.g. `css-loader` allows webpack to load .css files.

We also want to use a couple of extra libraries:

- [Basscss](http://www.basscss.com/) for CSS
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/) for icons

```bash
npm i basscss font-awesome -S
```

## Webpack config

We need to add a __webpack.config.js__ at the root. Copy it from here <https://github.com/sporto/elm-tutorial-app/blob/130-webpack/webpack.config.js>

#### Things to note:

- This config creates a Webpack dev server, see the key `devServer`. We will be using this server for development instead of Elm reactor.
- Entry point for our application will be `./src/index.js`, see the `entry` key.

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
    <div id="main">Loading...</div>
    <script src="/app.js"></script>
  </body>
</html>
```

## index.js

This is the entry point that Webpack will look for when creating a bundle. Add __src/index.js__:

```js
'use strict';

require('basscss/css/basscss.css');
require('font-awesome/css/font-awesome.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.embed(Elm.Main, mountNode);
```

## package.json

Finally we want to add some npm scripts so we can run our servers easily. In __package.json__ replace `scripts` with:

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server"
},
```

- So now `npm run api` will run our fake server.
- `npm run builld` will create webpack build an put the bundles in `dist`.
- `npm run watch` runs the webpack watcher and puts bundles in `dist` as we change our source.
- `npm run dev` runs the webpack dev server

## Test

Let's test our setup





