# Multiple modules

Our application is going to grow fast, so keeping things in one file will become hard to maintain quite fast. 

### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies. For example we might have:

- A `Main` module which has a `Player` type on it.
- A `View` module that imports the `Player` type declared in `Main`.
- `Main` importing `View` to render the view.

We now have a circular dependency:

```
Main --> View
View --> Main
```

#### How to break it?

In this case what we need to do is to move the `Player` type out of `Main`, somewhere it can be imported by both `Main` and `View`. 

To deal with circular dependencies in Elm the easiest thing to do is to split your application into smaller modules. In this particular example we can create another module that can be imported by both `Main` and `View`. We will have three modules:

- Main
- View
- Models (contains the Player type)

Now the dependencies will be:

```
Main --> Models
View --> Models
```

There is no circular dependency anymore.

Try creating separate modules for things like __actions__, __models__, __effects__ and __utilities__, which are modules that are usually imported by many components.

## Breaking the application

Let's break the application in smaller modules:

__src/Actions.elm__

```
module Actions (..) where

type Action
  = NoOp
```

__src/Models.elm__

```elm
module Models (..) where

type alias AppModel =
  {}

initialModel : AppModel
initialModel =
  {}
```

__src/Update.elm__

```elm
module Update (..) where

import Models exposing (..)
import Actions exposing (..)
import Effects exposing (Effects)

update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  ( model, Effects.none )
```

__src/View.elm__

```elm
module View (..) where

import Html exposing (..)
import Actions exposing (..)
import Models exposing (..)

view : Signal.Address Action -> AppModel -> Html
view address model =
  div
    []
    [ text "Hello" ]
```

__src/Main.elm__

```elm
module Main (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task
import StartApp
import Actions exposing (..)
import Models exposing (..)
import Update exposing (..)
import View exposing (..)


init : ( AppModel, Effects Action )
init =
  ( initialModel, Effects.none )


app : StartApp.App AppModel
app =
  StartApp.start
    { init = init
    , inputs = []
    , update = update
    , view = view
    }


main : Signal.Signal Html
main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks
```

Also __elm-package.json__ needs to be changed:

```json
...
"source-directories": [
    "src"
],
...
```

Without this the Elm compiler will try to find the imports in the root of our project and fail.

You can find the code here <https://github.com/sporto/elm-tutorial-app/tree/030-multiple-modules>

---

There are a lot more `import ...` statements now, this is a necessary drawback of splitting code into many modules.

## Exposing functions

Many import are using `expose (..)`, this means that we bring all the functions from that module into the current namespace.

I recommend using `expose (..)` when the module you are including will not create ambiguity about where something is coming from.

For example:

- Html exposes `div`, `a`, etc. these are so common that is clear where they are coming from.

- `Signal`, `Task` and `Effect` they all implement `map`. So it is quite confusing to use `expose(..)` with these.
