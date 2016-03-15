# Initial code

In the application folder install the Elm modules we will be using:

```bash
elm package install evancz/start-app
elm package install evancz/elm-http
elm package install sporto/hop 2.1
```

`sporto/hop` is the router we will be using in this tutorial.

#### Versions

Libraries change and major updates could be release. So it is worth mentioning what versions this tutorial is using:

- StartApp : `2.0.2`
- Hop : `2.1`
- Http : `3.0`

#### Additional entries

We will be using modules like `Effects` and `Html` in our code. This are dependencies already of installed when installing `evancz/start-app`. But in order to have access to them in our code we need to list them in `elm-package.json`.

The easiest thing to do is to install them again:

```
elm package install evancz/elm-html
elm package install evancz/elm-effects
```

## First version

Let's build a basic StartApp application, put this code into `src/Main.elm`.

```elm
module Main (..) where

import Html exposing (..)
import Effects exposing (Effects, Never)
import Task
import StartApp

-- ACTIONS

type Action
  = NoOp


-- MODEL

type alias Model =
  {}

initialModel : Model
initialModel =
  {}


-- UPDATE

update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, Effects.none )


-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div
    []
    [ text "Hello" ]


-- START APP

init : ( Model, Effects Action )
init =
  ( initialModel, Effects.none )

app : StartApp.App Model
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

This should be familiar by now. This application renders a view with the message "Hello" and does nothing else.

Try it by running elm reactor:

```
elm reactor
```

And browsing to `http://localhost:8000/src/Main.elm`. 

Your application code should look like <https://github.com/sporto/elm-tutorial-app/tree/020-initial-app>.
