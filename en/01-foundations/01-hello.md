# Hello World

## Installing Elm

Go to http://elm-lang.org/install and download the appropriate installer for your system.

## Our first Elm application

Let's write our first Elm application. Create a folder for your application. In this folder run the following command in the terminal:

```bash
elm-package install elm-lang/html
```

This will inform you that additional packages are needed, show you the proposed upgrade plan, and ask you to confirm the upgrade plan.  If you are running elm 0.18.0, the upgrade plan will include elm-lang/core, elm-lang/html, and elm-lang/virtual-dom packages.

This will create an _elm-package.json_ file and _elm-stuff_ directory in the same project directory, and then install the specified modules. Your modules themselves are saved in the _elm-stuff_ directory, while their specifications are saved in the _elm-package.json_ file.

Add a `Hello.elm` file, with the following code:

```elm
module Hello exposing (..)

import Html exposing (text)


main =
    text "Hello"
```

Go to the project folder on the terminal and type:

```bash
elm reactor
```

This should show you:

```
elm reactor 0.18.0
Listening on http://0.0.0.0:8000/
```

Open `http://0.0.0.0:8000/` on a browser. And click on `Hello.elm`. You should see `Hello` on your browser.

Note to you might see a warning about a missing type annotation for `main`. Ignore this for now, we will get to type annotations later.

Let's review what is happening here:

### Module declaration

```
module Hello exposing (..)
```

Every module in Elm must start with a module declaration, in this case the module name is called `Hello`. It is a convention to name the file and the module the same e.g. `Hello.elm` contains `module Hello`.

The `exposing (..)` part of the declaration specifies what function and types this module exposes to the other modules importing this. In this case we expose everything `(..)`.

### Imports

```
import Html exposing (text)
```

In Elm you need to import the __modules__  you want to use explicitly. In this case we want to use the __Html__ module. 

This module has many functions to work with html. We will be using `.text` so we import this function into the current namespace by using `exposing`.

### Main

```
main =
    text "Hello"
```

Front end applications in Elm start on a function called `main`. `main` is a function that returns an element to draw into the page. In this case it returns an Html element (created by using `text`).

### Elm reactor

Elm __reactor__ creates a server that compiles Elm code on the fly. __reactor__ is useful for developing applications without worrying too much about setting up a build process. However __reactor__ has limitations, so we will need to switch to a build process later on.
