# Hello World

## Installing Elm

Go to http://elm-lang.org/install and download the appropriate installer for your system.

## Our first Elm application

Let's write our first Elm application. Create a folder for your application. In this folder run the following command in the terminal:

```bash
elm package install elm-lang/html
```

This will install the _html_ module. Then add a `Hello.elm` file, with the following code:

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"
```

Go to this folder on the terminal and type:

```bash
elm reactor
```

This should show you:

```
elm reactor 0.17.0
Listening on http://0.0.0.0:8000/
```

Open `http://0.0.0.0:8000/` on a browser. And click on `Hello.elm`. You should see `Hello` on your browser.

Let's review what is happening here:

### imports

In Elm you need to import the __modules__  you want to use explicitly. In this case we want to use the __Html__ module. 

This module has many functions to work with html. We will be using `.text` so we import this function into the current namespace by using `exposing`.

### main

Front end applications in Elm start on a function called `main`. `main` is a function that returns an element to draw into the page. In this case it returns an Html element (created by using `text`).

### elm reactor

Elm __reactor__ creates a server that compiles Elm code on the fly. __reactor__ is useful for developing applications without worrying too much about setting up a build process. However __reactor__ has limitations, so we will need to switch to a build process later on.
