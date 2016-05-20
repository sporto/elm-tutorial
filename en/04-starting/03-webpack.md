# Webpack

__Elm reactor__ is great for prototyping simple applications, but for a bigger app it falls short. At it is now  __reactor__ doesn't support talking with external JavaScript or importing external CSS. To overcome these issues we will use __Webpack__ to compile our Elm code instead of Elm reactor.

Webpack is a code bundler. It looks at your dependency tree and only bundles the code that is imported. Webpack can also import CSS and other assets inside a bundle. Read more about Webpack [here](https://webpack.github.io/).

There are many alternatives that you can use to achieve the same a Webpack, for example:

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- Or if using a framework like Rails or Phoenix you can bundle the Elm code and CSS using them.

## Installing webpack and loaders

Install webpack and associated packages:

```bash
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@3 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
```

This tutorial is using __webpack__ version __1.13__ and __elm-webpack-loader__ version __3.0__.

Loaders are extensions that allow webpack to load different formats. E.g. `css-loader` allows webpack to load .css files.

We also want to use a couple of extra libraries:

- [Basscss](http://www.basscss.com/) for CSS, `ace-css` is the Npm package that bundles common Basscss styles
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/) for icons

```bash
npm i ace-css@1 font-awesome@4 -S
```

## Webpack config

We need to add a __webpack.config.js__ at the root:

TODO




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

// The third value on embed are the initial values for incomming ports into Elm
var app = Elm.Main.embed(mountNode);
```

## Install Elm packages

Run:

```
elm package install elm-lang/html
```

## Initial Elm app

Create a basic Elm app. In __src/Main.elm__:

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App

-- MODEL

type alias Model = String

init : (Model, Cmd Msg)
init =
  ("Hello" , Cmd.none)
  
-- MESSAGES

type Msg
  = NoOp

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ text model ]

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

-- MAIN

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }TODO
```

## package.json

Finally we want to add some npm scripts so we can run our servers easily. In __package.json__ replace `scripts` with:

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

- So now `npm run api` will run our fake server.
- `npm run build` will create a webpack build and put the bundles in `dist`.
- `npm run watch` runs the webpack watcher which puts the bundles in `dist` as we change our source code.
- `npm run dev` runs the webpack dev server.

## Test it

Let's test our setup

In a terminal window run:

```
npm run dev
```

If you browse to `http://localhost:3000/` you should see our application, which outputs "Hello".

Your application code should look like <https://github.com/sporto/elm-tutorial-app/tree/040-webpack>.



