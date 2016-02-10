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
