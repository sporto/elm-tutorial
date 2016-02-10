# Webpack

__Elm reactor__ is great for prototyping simple applications, but for a bigger app it falls short. At the moment __reactor__ won't let us send talk with external JavaScript and won't let us import external CSS. To fix this we will be compiling our Elm code ourselves using __Webpack__.

Webpack is a code bundler. It looks at your dependency tree and only bundles the code that is imported. Webpack can also import CSS and other assets inside a bundle. Read more about Webpack [here](https://webpack.github.io/).


## Installing webpack and loaders

Stop Elm reactor if running and install webpack:

```bash

```