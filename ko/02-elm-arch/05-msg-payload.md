> This page covers Elm 0.18

# 데이터를 포함하는 메시지 (Messages with payload)

메시지에 데이터를 포함할 수 있습니다:

```elm
module Main exposing (..)

import Html exposing (Html, button, div, text, program)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Int


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )



-- MESSAGES


type Msg
    = Increment Int



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick (Increment 2) ] [ text "+" ]
        , text (toString model)
        ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )



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

`Increment` 메시지가 정수를 포함하고 있습니다:

```elm
type Msg
    = Increment Int
```

뷰에서도 데이터를 전달하여 메시지를 발생시킵니다:

```elm
onClick (Increment 2)
```

마지막으로 update 에서는 __패턴 매칭__ 으로 데이터를 뽑아냅니다:

```elm
update msg model =
    case msg of
        Increment howMuch ->
            ( model + howMuch, Cmd.none )
```
