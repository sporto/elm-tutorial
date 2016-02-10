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

## Webpack config

We need to add a __webpack.config.js__ at the root. Copy it from here <https://github.com/sporto/elm-tutorial-app/blob/130-webpack/webpack.config.js>

