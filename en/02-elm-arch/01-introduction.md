# Introduction

When building front end applications in Elm we use the pattern known as the Elm architeture. This pattern provides a way of creating self contained components that can be composed indefinitely.

Elm provides the `Html.App` module for this. This is easier to understand by building a small app.

Install elm-http:

```elm
elm package install elm-lang/html
```

Create a file called __App.elm__:

```elm
module Main exposing (..)

import Html exposing (Html, div, text)
import Html.App

-- MODEL

type alias Model = String

init : (Model, Cmd Msg)
init =
  ( "Hello" , Cmd.none )
  
-- MESSAGES

type Msg
  = NoOp

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ text model ]

-- UPDATE

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
  
-- MAIN

main =
  Html.App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
```

You can run this program running:

```bash
elm reactor
```

And opening http://localhost:8000/App.elm

This program show "Hello". This a lot of code for just doing that! But don't mind, let's go through the program to understand the structure of an Elm application.

