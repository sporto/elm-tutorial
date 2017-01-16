> This page covers Elm 0.18

# Introduction

When building front end applications in Elm, we use the pattern known as the Elm architecture. This pattern provides a way of creating self contained components that can be reused, combined, and composed in endless variety.

Elm provides the `Html` module for this. This is easier to understand by building a small app.

Install elm-html:

```elm
elm package install elm-lang/html
```

Create a file called __App.elm__:

```elm
module App exposing (..)

import Html exposing (Html, div, text, program)


-- MODEL


type alias Model =
    String


init : ( Model, Cmd Msg )
init =
    ( "Hello", Cmd.none )



-- MESSAGES


type Msg
    = NoOp



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text model ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- MAIN


main : Program Never Model Msg
main =
    program
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

This is a lot of code for just showing "Hello", but it will help us understand the structure of even very complex Elm applications.

