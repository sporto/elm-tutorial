# Hello World

## Installing Elm

Go to http://elm-lang.org/install and download the appropriate installer for your system.

## Our first Elm application

Let's write our first Elm application, create a folder for your application and add a `Hello.elm` file. In this file write:

```elm
import Html

main : Html.Html
main =
  Html.text "Hello"
```

Go to this folder on the terminal and type:

```
elm reactor
```

This should show you:

```
elm reactor 0.16.0
Listening on http://0.0.0.0:8000/
```

Open `http://0.0.0.0:8000/` on a browser. And click on `Hello.elm`. You should see `Hello` on your browser.

### imports

In Elm you need to import the __modules__  you want to use explicitly. In this case we want to use the __Html__ module from core. This module has many functions to work with html, we will be using `.text`.

### main

Every application in Elm starts on a `main` function. `main` should be a function that returns an static element or a signal of elements (more on signals later). In this case `main` just returns an `Html.Html` element (Html element from the Html module).

### elm reactor

Elm __reactor__ creates a server that compiles Elm code on the fly. __reactor__ is useful for developing applications without worring too much about setup up a build process. However __reactor__ has limitations, so we will need to switch to a build process later on.
