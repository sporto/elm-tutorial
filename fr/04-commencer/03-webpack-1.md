> Cette page couvre Elm 0.18

# Webpack

__Elm reactor__ est parfait pour réaliser le prototype d'applications simple, mais n'est pas suffisant pour des applications plus grandes. Actuellement, __reactor__ ne permet pas de communiquer avec du JavaScript externe ou d'importer du CSS externe. Pour remédier à ces problèmes, nous utiliserons __Webpack__ pour compiler notre code Elm, plutôt que __reactor__.

Webpack est un programme qui rassemble votre code dans un *bundle*. Il analyse l'arbre de dépendances du code et n'ajoute au *bundle* que le code qui est vraiment utilisé. Webpack peut aussi importer du CSS et d'autres ressources dans un *bundle*. Pour en savoir plus sur Webpack, consultez le [site](https://webpack.github.io/).

Il existe de nombreuses alternatives qui proposent les mêmes fonctionnalités que Webpack :

- [Browserify](http://browserify.org/)
- [Gulp](http://gulpjs.com/)
- [StealJS](http://stealjs.com/)
- [JSPM](http://jspm.io/)
- ou, si vous utilisez un framework comme Rails ou Phoenix, vous pouvez les utiliser pour rassembler le code Elm et CSS dans un *bundle*.

## Prérequis

Il vous faudra NodeJS en version 4 ou supérieure pour que ces bibliothèques fonctionnent correctement.

## Installation de webpack et des *loaders*

Installez Webpack et les paquets associés :

```bash
npm i webpack@1 webpack-dev-middleware@1 webpack-dev-server@1 elm-webpack-loader@4 file-loader@0 style-loader@0 css-loader@0 url-loader@0 -S
```

Ce tutoriel utilise __Webpack__ version __1.13__ et __elm-webpack-loader__ version __4.1__.

Les *loaders* sont des extensions qui permettent à Webpack de charger différents formats. Ainsi, `css-loader` permet à Webpack de charger les fichiers .css.

Installons aussi quelques bibliothèques supplémentaires :

- [Basscss](http://www.basscss.com/) pour le CSS, `ace-css` est le paquet npm qui rassemble des styles populaires en Basscss
- [FontAwesome](https://fortawesome.github.io/Font-Awesome/) pour les icônes

```bash
npm i ace-css@1 font-awesome@4 -S
```

## Configuration de Webpack

Il nous faut créer un fichier __webpack.config.js__ à la racine :

```js
var path = require("path");

module.exports = {
  entry: {
    app: [
      './src/index.js'
    ]
  },

  output: {
    path: path.resolve(__dirname + '/dist'),
    filename: '[name].js',
  },

  module: {
    loaders: [
      {
        test: /\.(css|scss)$/,
        loaders: [
          'style-loader',
          'css-loader',
        ]
      },
      {
        test:    /\.html$/,
        exclude: /node_modules/,
        loader:  'file?name=[name].[ext]',
      },
      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-webpack?verbose=true&warn=true',
      },
      {
        test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'url-loader?limit=10000&mimetype=application/font-woff',
      },
      {
        test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
        loader: 'file-loader',
      },
    ],

    noParse: /\.elm$/,
  },

  devServer: {
    inline: true,
    stats: { colors: true },
  },

};
```

#### Notes

- Cette configuration crée un serveur de développement Webpack (cf. la clef `devServer`). Nous utiliserons ce serveur de développement plutôt que __Elm reactor__.
- Le point d'entrée de notre application sera `./src/index.js` (cf. la clef `entry`).
