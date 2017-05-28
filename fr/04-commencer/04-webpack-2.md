> Cette page couvre Elm 0.18

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
elm-package install elm-lang/html
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

