> This page covers Elm 0.18

# Subscriptions

In Elm, using __subscriptions__ is how your application can listen for external input. Some examples are:

- [Keyboard events](http://package.elm-lang.org/packages/elm-lang/keyboard/latest/Keyboard)
- [Mouse movements](http://package.elm-lang.org/packages/elm-lang/mouse/latest/Mouse)
- Browser locations changes
- [Websocket events](http://package.elm-lang.org/packages/elm-lang/websocket/latest/WebSocket)

To illustrate this, let's create an application that responds to both keyboard and mouse events.

First, install the required libraries:

```bash
elm package install elm-lang/mouse
elm package install elm-lang/keyboard
```

Then, create this program:

```elm
module Main exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ text (toString model) ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMsg
        , Keyboard.downs KeyMsg
        ]



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

Run this program with Elm reactor. Each time you click the mouse you will see the counter increasing by one; each time you press a key you will see the counter increasing by 2.

---

Let's review the important parts relevant to subscriptions in this program.

### Messages

```elm
type Msg
    = MouseMsg Mouse.Position
    | KeyMsg Keyboard.KeyCode
```

We have two possible messages: `MouseMsg` and `KeyMsg`. These will trigger when the mouse or the keyboard are pressed, accordingly.

### Update

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMsg position ->
            ( model + 1, Cmd.none )

        KeyMsg code ->
            ( model + 2, Cmd.none )
```

Our update function responds to each message differently, so it increases the counter by one when we press the mouse or by two when we press a key.

### Subscriptions

```elm
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch ➌
        [ Mouse.clicks MouseMsg ➊
        , Keyboard.downs KeyMsg ➋
        ]
```

Here we declare the things we want to listen to. We want to listen to `Mouse.clicks` ➊ and `Keyboard.downs` ➋. Both of these functions take a message constructor and return a subscription.

We use `Sub.batch` ➌ so we can listen to both of them. `batch` takes a list of subscriptions and returns one subscription which includes all of them.

Also note that in this example our subscriptions are static, they don't change during the life our application. But they don't have to be like that. They could change depending on what is in the `model`, this is why we pass the model to `subscriptions`. 
