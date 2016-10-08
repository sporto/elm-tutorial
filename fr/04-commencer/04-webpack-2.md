# Webpack 2

## index.html

Puisqu'on n'utilise plus __Elm reactor__, il nous faut créer notre propre HTML pour contenir notre application. Créez le fichier __src/index.html__:

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Example d'une application en Elm</title>
  </head>
  <body>
    <div id="main"></div>
    <script src="/app.js"></script>
  </body>
</html>
```

## index.js

Il s'agit du point d'entrée que Webpack va chercher quand il va créer un *bundle*. Ajoutez le fichier __src/index.js__ :

```js
'use strict';

require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');

// On importe index.html pour qu'il soit intégré au *dist*
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.getElementById('main');

var app = Elm.Main.embed(mountNode);
```

## Installer les paquets Elm

Exécutez :

```bash
elm package install elm-lang/html
```

## Répertoire source

Notre code source se trouvera dans le répertoire `src`. Il nous faut indiquer à Elm où chercher les dépendances. Dans __elm-package.json__, mmodifiez :

```json
...
"source-directories": [
    "src"
],
...
```

Sans ça, le compilateur Elm cherchera les imports à la racine du projet, et échouera.

## Application Elm initiale

Créez une application Elm de base. Dans __src/Main.elm__ :

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


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

Pour finir, ajoutons quelques scripts npm, pour pouvoir lancer nos serveurs facilement. Dans __package.json__, remplacez la clef `scripts` par :

```json
"scripts": {
    "api": "node api.js",
    "build": "webpack",
    "watch": "webpack --watch",
    "dev": "webpack-dev-server --port 3000"
},
```

Désormais :
- `npm run api` va lancer noter faux serveur
- `npm run build` va créer un *build* webpack et mettre les *bundles* dans `dist`
- `npm run watch` exécute le *watcher* de Webpack, qui ajoute les *bundles* dans `dist` à chaque fois que l'on change le code
- `npm run dev` exécute le serveur de développement de Webpack.

## Test

Testons notre configuration ! Dans un terminal, exécutez :

```bash
npm run dev
```

Si vous allez sur `http://localhost:3000/`, vous devriez voir notre application, qui affiche "Hello".

Le code de votre application devrait correspondre à cela : <https://github.com/sporto/elm-tutorial-app/tree/02-webpack>.
