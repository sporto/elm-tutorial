# Multiple modules

Our application is going to grow fast, so keeping things in one file will become hard to maintain quite fast. 

### Circular dependencies

Another issue we are likely to hit at some point will be circular dependencies in Elm. For example we might have:

- A `Main` module which has a `Player` model on it.
- A `PlayerView` module that renders a player, this want to use the `Player` model declared in `Main`.
- `Main` calls `PlayerView` to render the player.

We now have a circular dependency:

```
Main --> PlayerView
PlayerView --> Main
```

#### How to break it?

In this case what we need to do is move the `Player` model out of `Main`. In a place where it can be imported by both `Main` and `PlayerView`. We will end up with three modules:

- Main
- PlayerView
- Models (contains Player)

To deal with circular dependencies in Elm the easiest thing to do is to break your application in smaller modules. Try creating smaller modules for things like __actions__, __models__, __effects__ and __utilities__, which are modules that are usually imported by many components.

## Breaking our application

Let's break our application in smaller modules:

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

You can find the code here <https://github.com/sporto/elm-tutorial-app/tree/120-multiple-modules>

---

There are a lot more `import ...` statements now, this is a necessary drawback of splitting code into many modules.

## Exposing functions

Many import are using `expose (..)`, this means that we bring all the functions from that module into the current namespace.

My rule for using `expose (..)` is as follows:

- Common modules that are unlikely to cause collision expose everything. e.g Html exposes `div`, `a`, etc.

- Common modules that have methods named are not 'mixed in'. For example `Signal`, `Task` and `Effect` they all implement `map`. So I prefer to be explicit and use `Effect.map` later on.

- Application modules that are in the same level are 'mixed in'. E.g. `Main` and `Actions` are in the same level, `Action` are actions that relate directly to `Main`.

- Application modules that are in a different level are not mixed in. For example we might have `Main.elm` and `Players/Models.elm`. If `Main` needs to import `Players.Models` it should not do it using `expose(..)`.

